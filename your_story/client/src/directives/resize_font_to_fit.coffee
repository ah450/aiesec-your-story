angular.module 'aiesec'
  .directive 'fontToFit', () ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) ->
        text = element.text().trim().replace(/[\{\}]/g, '')
        text = scope.$eval text
        width = element.width()
        fontSize = parseInt element.css('font-size')
        fontSizeMax = width/text.length
        fontSize = Math.min fontSize, fontSizeMax
        element.css('font-size', fontSize + 'px')




