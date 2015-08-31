###
Toggles a set of classes on an element.
  If clickToggleTarget attribute is present the classes will be toggled on it.
  Otherwise they will be targeted on the directive's element.
  if preventDefault  attribute is a truthy value (present) the event handler
  will return false.
###
angular.module 'aiesec'
  .directive 'clickToggle', () ->
    directive =
      restrict: 'A'
      scope:
        klass: "@clickToggle"
        target: "@?clickToggleTarget"
        preventDefault: "@?preventDefault"
      link: (scope, element) ->
        element.click ->
          target = element
          if scope.target
            target = $ scope.target
          target.toggleClass scope.klass
          scope.$emit 'toggled'
          scope.$apply()
          return false if scope.preventDefault