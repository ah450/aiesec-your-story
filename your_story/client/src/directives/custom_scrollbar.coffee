angular.module 'aiesec'
  .directive 'customScrollbar', () ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) ->
        element.mCustomScrollbar()