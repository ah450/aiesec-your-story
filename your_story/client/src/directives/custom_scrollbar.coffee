angular.module 'aiesec'
  .directive 'customScrollbar', () ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) ->
        config = {}
        if attrs.mcsTheme
          config.theme = attrs.mcsTheme
        if attrs.mcsAxis
          config.axis = attrs.mcsAxis
        element.mCustomScrollbar config