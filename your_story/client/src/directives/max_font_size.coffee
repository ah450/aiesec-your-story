angular.module 'aiesec'
  .directive 'maxFontSize', ->
    directive =
      restrict: 'A',
      scope:
        text: "=maxFontSizeText"
      link: (scope, element, attrs) ->
        width = element.width()
        fontSizeMax = width / scope.text.length * 2
        element.css 'font-size', fontSizeMax + 'px'