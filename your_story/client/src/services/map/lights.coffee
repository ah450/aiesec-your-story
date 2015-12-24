angular.module 'aiesec'
  .factory 'mapLights', ->
    (scene, camera) ->
      ambientLight = new THREE.AmbientLight 0x808080
      scene.add ambientLight
      pointLight = new THREE.PointLight 0xFFFFFF, 0.5
      pointLight.position.set 0, 30, 40
      camera.add pointLight
