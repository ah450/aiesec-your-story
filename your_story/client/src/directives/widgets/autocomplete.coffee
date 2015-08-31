# selectFunc is for setting the element value
# renderFunc is for rendering the item in the results drop down list
angular.module 'aiesec'
  .directive 'autoComplete', ->
    directive =
      restrict: 'A'
      scope:
        renderFunc: "=acRender"
        sources: "=acSources"
        selectFunc: "=acSelect"
      link: (scope, element, attrs, ngModel) ->
        true