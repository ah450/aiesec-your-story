angular.module 'aiesec'
  .directive 'copySize', () ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) ->
        target = angular.element attrs.copySize
        target.ready () ->
          element.css('width', target.css('width'))
          element.css('height', target.css('height'))