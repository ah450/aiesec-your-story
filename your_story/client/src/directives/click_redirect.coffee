angular.module 'aiesec'
  .directive 'clickRedirect', ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) ->
        element.click ->
          $ attrs.clickRedirect
            .toggle 'click'
          return false