angular.module 'aiesec'
  .controller 'ImpactMapController', ($scope, MapTextures, mapLights,
    createEarthCloud, mapToSphere, addSkyBox, Meshes, stateToMapCoord,
    $q, Participant, Animation) ->
    # Initialize Renderer
    renderer = new THREE.WebGLRenderer
      canvas: $('#impactMapCanvas')[0]
      antialias: true

    renderer.shadowMapEnabled = true
    renderer.shadowMapType = THREE.PCFSoftShadowMap
    scene = new THREE.Scene()
    aspectRatio = window.innerWidth / window.innerHeight
    camera = new THREE.PerspectiveCamera 45, aspectRatio, 0.1, 100000
    camera.position.set 0, 0, 100
    renderer.setSize window.innerWidth, window.innerHeight
    resizeFunction = ->
      width = window.innerWidth
      height = window.innerHeight
      renderer.setSize width, height
      camera.aspect = width / height
      camera.updateProjectionMatrix()
    $(window).on 'resize', resizeFunction

    texturesPromise = $q.all MapTextures
    meshesPromise = $q.all Meshes
    participantsPromise = Participant.all(100)

    $scope.$on '$destroy', ->
      $(window).off 'resize', resizeFunction

    earthRadius = 25

    cameraParent = new THREE.Object3D
    pivot = new THREE.Object3D
    pivot.add camera
    cameraParent.add pivot
    # Add lights
    scene.add cameraParent
    mapLights scene, camera

    earthMarkerGroup = new THREE.Object3D
    allMarkerGroup = new THREE.Object3D
    inEgyptMarkers = new THREE.Object3D
    outEgyptMarkers = new THREE.Object3D
    markers = []
    cloud = null
    clock = new THREE.Clock true
    animations = []
    # Raycasting
    INTERSECTED = null
    raycaster = new THREE.Raycaster
    mousePos = new THREE.Vector2

    onMouseMove = (event) ->
      mousePos.x = (event.clientX / window.innerWidth) * 2 - 1
      mousePos.y =  - (event.clientY / window.innerHeight) * 2 + 1

    $(window).on 'mousemove', onMouseMove
    $scope.$on '$destory', ->
      $(window).off 'mousemove', onMouseMove


    egyptMarkers = []
    nonEgyptMarkers = []

    createMarkers = ->
      markerPromises = $q.all([meshesPromise, participantsPromise])
      markerPromises.then (values) ->
        meshes = values[0]
        participants = values[1]
        mesh = meshes['marker']
        participants.data.forEach (participant) ->
          return if participant.stories.length is 0
          story = participant.stories[0]
          country = story.state.country
          console.log country
          return if not country of stateToMapCoord
          stateMapCoord = stateToMapCoord[country]
          posVector = mapToSphere stateMapCoord.x, stateMapCoord.y,
            earthRadius + 0.2
          material = new THREE.MeshPhongMaterial
            color: 0x2196F3
            shininess: 1
          markerObject = new THREE.Mesh mesh.geometry, material
          markerObject.participant = participant
          markerObject.scale.set 0.5, 0.5, 0.5
          markerObject.position.add posVector
          markerObject.lookAt new THREE.Vector3 0, 0, 0
          markerObject.castShadow = true
          markers.push markerObject
          if country is 'Egypt'
            egyptMarkers.push markerObject
          else
            nonEgyptMarkers.push markerObject
          scene.add markerObject

    createMeshes = (textures) ->

      earthMaterial = new THREE.MeshPhongMaterial
        map: textures['earth-diffuse']
        bumpMap: textures['earth-bump']
        bumpScale: 0.5
        shininess: 10
        specularMap: textures['earth-spec']
        specular: 0xE0E0E0

      earthGeometry = new THREE.SphereGeometry earthRadius, 128, 128
      earth = new THREE.Mesh earthGeometry, earthMaterial
      earth.receiveShadow = true
      earthMarkerGroup.add earth

      scene.add earthMarkerGroup

      createEarthCloud earthRadius
        .then (cloudMesh) ->
          cloud = cloudMesh
          scene.add cloud

    handleAnimations = ->
      _.remove animations, (animation) ->
        not animation.running animation.ticks
      animations.forEach (animation) ->
        animation.animate animation.ticks

    registerAnimation = (animation) ->
      animation.register 0
      animation.ticks = 0
      animations.push animation


    animate = ->
      delta = clock.getDelta()
      cloud.rotation.y += 0.1 * delta
      cloud.rotation.z += 0.05 * delta
      # Animations with transition functions
      handleAnimations()


    handleIntersection = ->
      raycaster.setFromCamera mousePos, camera
      intersects = raycaster.intersectObjects markers
      if intersects.length isnt 0
        if INTERSECTED isnt intersects[0].object
          if INTERSECTED isnt null
            INTERSECTED.material.emissive.setHex INTERSECTED.currentHex
          INTERSECTED = intersects[0].object
          INTERSECTED.currentHex = INTERSECTED.material.emissive.getHex()
          INTERSECTED.material.emissive.setHex 0xff0000
      else
        # Reset intersections
        if INTERSECTED isnt null
          INTERSECTED.material.emissive.setHex INTERSECTED.currentHex
          INTERSECTED = null


    render =  ->
      animations.forEach (animation) ->
        animation.ticks++
      animate()
      handleIntersection()
      renderer.render scene, camera
      requestAnimationFrame render

    texturesPromise.then createMeshes
      .then ->
        createMarkers().then ->
            requestAnimationFrame render

    movementSpeedArrow = 0.02
    $scope.movementSpeedButton = 0.5



    $scope.moveUp =  (speed) ->
      # cameraParent.rotation.x -= speed
      # console.log cameraParent.rotation.x
      target = cameraParent.rotation.x - speed
      updateFunction = (value) ->
        cameraParent.rotation.x = value
      animation = new Animation 'easeOutQuart', cameraParent.rotation.x,
        target, 100, updateFunction
      registerAnimation animation

    $scope.moveDown =  (speed) ->
      $scope.moveUp -speed

    $scope.moveRight = (speed) ->
      target = cameraParent.rotation.y + speed
      updateFunction = (value) ->
        cameraParent.rotation.y = value
      animation = new Animation 'easeOutQuart', cameraParent.rotation.y,
        target, 100, updateFunction
      registerAnimation animation


    $scope.moveLeft = (speed) ->
      $scope.moveRight -speed

    $scope.inEgypt = ->
      nonEgyptMarkers.forEach (m) ->
        m.visible = false
      egyptMarkers.forEach (m) ->
        m.visible = true

    $scope.outEgypt = ->
      nonEgyptMarkers.forEach (m) ->
        m.visible = true
      egyptMarkers.forEach (m) ->
        m.visible = false

    keyDown =  (event) ->
      switch event.which
        when keyKodes.arrows.up then $scope.moveUp(movementSpeedArrow)
        when keyKodes.arrows.down then $scope.moveDown(movementSpeedArrow)
        when keyKodes.arrows.left then $scope.moveLeft(movementSpeedArrow)
        when keyKodes.arrows.right then $scope.moveRight(movementSpeedArrow)

    $(window).on 'keydown', keyDown

    $scope.$on '$destroy', ->
      $window.off 'keyDown', keyDown

    zoomIn = (rate) ->
      camera.zoom *= rate
      camera.updateProjectionMatrix()

    zoomOut = (rate) ->
      zoomIn 1 / rate

    mouseWheelHandler = (event) ->
      if event.deltaY > 0
        zoomIn 1.1
      else if event.deltaY < 0
        zoomOut 1.1

    $(window).on 'mousewheel', mouseWheelHandler

    $scope.$on '$destroy', ->
      $window.off 'mousewheel', mouseWheelHandler

    MOUSE =
      start: null
      rotating: false

    mouseDownHandler = (event) ->
      if event.which is 1
          MOUSE.rotating = true
          MOUSE.start = new THREE.Vector2 event.clientX, event.clientY


    mouseMoveHandler = (event) ->
      if MOUSE.rotating
        rotateEnd = new THREE.Vector2 event.clientX, event.clientY
        delta = new THREE.Vector2
        delta.subVectors MOUSE.start, rotateEnd
        rotationX = 2 * Math.PI * delta.x / window.innerWidth  * 0.5
        rotationY = 2 * Math.PI * delta.y / window.innerHeight  * 0.5
        cameraParent.rotation.x += rotationY
        cameraParent.rotation.y += rotationX
        MOUSE.start.copy rotateEnd


    mouseUpHandler = (event) ->
      if event.which is 1
        MOUSE.start = null
        MOUSE.rotating = false

    $(renderer.domElement).on 'mousedown', mouseDownHandler
    $(renderer.domElement).on 'mouseup', mouseUpHandler
    $(renderer.domElement).on 'mousemove', mouseMoveHandler

    $scope.$on '$destroy', ->
      $(renderer.domElement).off 'mousedown', mouseDownHandler
      $(renderer.domElement).off 'mouseup', mouseUpHandler
      $(renderer.domElement).off 'mousemove', mouseMoveHandler


