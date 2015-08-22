angular.module 'aiesec'
  .directive 'lettering', () ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) ->
        element.addClass 'lettering-container'
        element.lettering()
