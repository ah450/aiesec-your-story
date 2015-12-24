angular.module 'aiesec'
  .factory 'Meshes', ($q) ->
    loader = new THREE.JSONLoader()

    markerDeferred = $q.defer()
    inEgyptDeferred = $q.defer()
    globeDeferred = $q.defer()

    meshes =
      'marker': markerDeferred.promise
      'inEgypt': inEgyptDeferred.promise
      'outEgypt': globeDeferred.promise

    loader.load 'assets/models/a.json', (geometry) ->
      markerDeferred.resolve
        geometry: geometry

    loader.load 'assets/models/egypt_pin.json', (geometry) ->
      inEgyptDeferred.resolve
        geometry: geometry

    loader.load 'assets/models/globe.json', (geometry) ->
      globeDeferred.resolve
        geometry: geometry

    return meshes