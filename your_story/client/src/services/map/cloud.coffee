angular.module 'aiesec'
  .factory 'createEarthCloud', ($q) ->
    (earthRadius) ->
      deferredMesh = $q.defer()
      canvasResult  = document.createElement 'canvas'
      canvasResult.width  = 1024
      canvasResult.height = 512
      contextResult = canvasResult.getContext '2d'

      geometry  = new THREE.SphereGeometry earthRadius + 0.2, 32, 32
      material  = new THREE.MeshPhongMaterial
        map   : new THREE.Texture canvasResult
        side    : THREE.DoubleSide
        transparent : true
        opacity   : 0.8
      mesh  = new THREE.Mesh(geometry, material)
      # load earthcloudmap
      imageMap  = new Image();
      imageMap.addEventListener "load", ->
        
        # create dataMap ImageData for earthcloudmap
        canvasMap = document.createElement 'canvas'
        canvasMap.width = imageMap.width
        canvasMap.height= imageMap.height
        contextMap  = canvasMap.getContext '2d'
        contextMap.drawImage imageMap, 0, 0
        dataMap = contextMap.getImageData 0, 0, canvasMap.width, canvasMap.height

        # load earthcloudmaptrans
        imageTrans  = new Image();
        imageTrans.addEventListener "load", ->
          # create dataTrans ImageData for earthcloudmaptrans
          canvasTrans   = document.createElement 'canvas'
          canvasTrans.width = imageTrans.width
          canvasTrans.height  = imageTrans.height
          contextTrans  = canvasTrans.getContext '2d'
          contextTrans.drawImage imageTrans, 0, 0
          dataTrans   = contextTrans.getImageData 0, 0,
            canvasTrans.width, canvasTrans.height
          # merge dataMap + dataTrans into dataResult
          dataResult    = contextMap.createImageData canvasMap.width,
            canvasMap.height
          offset = 0
          for y in [0...imageMap.height]
            for x in [0...imageMap.width]
              dataResult.data[offset + 0] = dataMap.data[offset + 0]
              dataResult.data[offset + 1] = dataMap.data[offset + 1]
              dataResult.data[offset + 2] = dataMap.data[offset + 2]
              dataResult.data[offset + 3] = 255 - dataTrans.data[offset + 0]
              offset += 4
          # update texture with result
          contextResult.putImageData dataResult, 0, 0
          material.map.needsUpdate = true
          deferredMesh.resolve mesh


        imageTrans.src  = 'assets/textures/earthcloudmaptrans.jpg'
 
      imageMap.src  = 'assets/textures/earthcloudmap.jpg'

      return deferredMesh.promise
