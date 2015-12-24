angular.module 'aiesec'
  .factory 'MapTextures', ($q) ->
    loader = new THREE.TextureLoader()

    earthBumpDeferred = $q.defer()
    earthSpecDeferred = $q.defer()
    earthDiffuseDeferred = $q.defer()

    starfieldDiffuseDeferred = $q.defer()

    textures =
      'earth-diffuse': earthDiffuseDeferred.promise
      'earth-bump': earthBumpDeferred.promise
      'earth-spec': earthSpecDeferred.promise
      'starfield-diffuse': starfieldDiffuseDeferred.promise

    loader.load 'assets/textures/world-map-v2.2.png', (texture) ->
      earthDiffuseDeferred.resolve texture

    loader.load 'assets/textures/world-map-v2.2-bump.jpg', (texture) ->
      earthBumpDeferred.resolve texture

    loader.load 'assets/textures/world-map-v2.2-specular.jpg', (texture) ->
      earthSpecDeferred.resolve texture

    loader.load 'assets/textures/galaxy_starfield.png', (texture) ->
      starfieldDiffuseDeferred.resolve texture


    return textures
