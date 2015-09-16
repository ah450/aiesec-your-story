# Directive for canvas element of multu file upload image preview widget
angular.module 'aiesec'
  .directive 'fgCanvas', ->
    directive =
      restrict: 'A',
      scope:
        urls: '=fgUrls'
        currentIndex: '=fgCurrentIndex'
      link: (scope, element, attrs) ->
        ctx = element[0].getContext '2d'
        rendered = false
        clearCanvas = ->
          ctx.clearRect 0, 0, element[0].width, element[0].height
        drawUrl = (url) ->
          image = new Image
          image.onload = () ->
            clearCanvas()
            ctx.drawImage image, 0, 0, element[0].width, element[0].height
            rendered = true
          image.src = url
        update = ->
          if angular.isUndefined(scope.urls) or scope.urls.length == 0
            if rendered
              rendered = false
              clearCanvas()
          else
            drawUrl scope.urls[scope.currentIndex]
        scope.$watch 'currentIndex', (newValue, oldValue) ->
          return if angular.isUndefined(newValue) or newValue == null
          update()

        scope.$watch 'urls', (newValue) ->
          return if angular.isUndefined(newValue) or newValue == null
          update()
          
