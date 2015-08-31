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
        if attrs.mscScrollPosition
          config.scrollbarPosition = attrs.scrollPosition
        if attrs.mcsWheelEnable
          config.mouseWheel = {enable: true}
        if attrs.mcsKeyboardEnable
          config.keyboard = {enable: true}
        element.mCustomScrollbar config