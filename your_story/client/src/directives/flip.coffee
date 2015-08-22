angular.module 'aiesec'
  .directive 'flip', () ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) ->
        element.click () ->
          angular.element attrs.flip
          .toggleClass 'flip'