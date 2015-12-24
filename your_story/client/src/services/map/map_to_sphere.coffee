angular.module 'aiesec'
  .factory 'mapToSphere', ->
    (mapX, mapY, earthRadius) ->
      degreePerPixelYAxis = 0.043
      degreePerPixelXAxis = 0.087
      centerY = 1990
      centerX = 2085
      diffYAxis = mapX - centerY
      diffXAxis = mapY - centerX
      vector = new THREE.Vector3 0, 0, earthRadius
      yRotation = degreePerPixelYAxis * diffYAxis * Math.PI / 180
      xRotation = degreePerPixelXAxis * diffXAxis * Math.PI / 180
      vector.applyAxisAngle new THREE.Vector3(1, 0, 0), xRotation
      vector.applyAxisAngle new THREE.Vector3(0, 1, 0), yRotation
      return vector