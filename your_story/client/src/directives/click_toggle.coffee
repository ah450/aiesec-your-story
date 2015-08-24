angular.module 'aiesec'
  .directive 'clickToggle', () ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) ->
        element.click ->
          element.toggleClass attrs.clickToggle
          return false if attrs.preventDefault