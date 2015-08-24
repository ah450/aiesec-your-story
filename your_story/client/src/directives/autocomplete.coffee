# selectFunc is for setting the element value
# renderFunc is for rendering the item in the results drop down list
angular.module 'aiesec'
  .directive 'autoComplete', ->
    directive =
      restrict: 'A',
      scope:
        renderFunc: "&acRender",
        sources: "=acSources",
        selectFunc: "&acSelect",
      link: (scope, element, attrs) ->
        autoCompleteConfig =
          minLength: 0
          source: scope.sources
          select: (event, ui) ->
            element.val scope.selectFunc(ui.item)
            scope.$apply()
            return false
        element.autocomplete autoCompleteConfig
        element.autocomplete 'instance'
          ._renderItem = (ul, item) ->
            newElement = $ '<li>'
              .append scope.renderFunc(item)
              .appendTo ul
            scope.$apply()
            return newElement
        scope.$on '$destroy', ->
          element.autocomplete 'destroy'

          