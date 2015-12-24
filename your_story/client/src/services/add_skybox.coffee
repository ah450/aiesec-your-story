angular.module 'aiesec'
  .factory 'addSkyBox', ($q)->
    (scene) ->
      deferred = $q.defer()
      urlPrefix = 'assets/textures'
      urls = [
        'posx.png', 'negx.png',
        'posy.png', 'negy.png',
        'posz.png', 'negz.png'
      ]
      urls = _.map urls, (url) ->
        "#{urlPrefix}/#{url}"
      THREE.ImageUtils.loadTextureCube urls, THREE.CubeReflectionMapping,
        (textureCube) ->
          material = new THREE.MeshBasicMaterial
            envMap: textureCube
            side: THREE.BackSide
          skyboxMesh = new THREE.Mesh new THREE.BoxGeometry(100000, 100000,
            100000), material
          scene.add skyboxMesh
          deferred.resolve true
      return deferred.promise