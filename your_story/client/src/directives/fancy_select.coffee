angular.module 'aiesec'
  .directive 'fancySelect', () ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) -> 
        element.keydown (event)->
          data = scope.options.data
          selected = scope.options.selected
          index = if selected then data.indexOf(selected) else -1
          clamp = (index)->
            if index < 0
              clamp(data.length + index)
            else if index >= data.length
              index % data.length
            else
              return index
          if event.which == keyKodes.arrows.left
            ++index
            index = clamp(index)
            scope.selected = data[index]
          else if event.which == keyKodes.arrows.right
            --index
            index = clamp(index)
            scope.selected = data[index]
          return true

            
            

