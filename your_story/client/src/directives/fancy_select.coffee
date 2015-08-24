angular.module 'aiesec'
  .directive 'fancySelect', () ->
    directive =
      restrict: 'A'
      link: (scope, element, attrs) -> 
        element.keydown (event)->
          data = scope.options.data
          selected = scope.options.selected
          clamp = (index)->
            if index < 0
              clamp(data.length + index)
            else if index >= data.length
              index % data.length
            else
              return index
          if event.which == keyKodes.arrows.down
            if selected
              index = data.indexOf(selected)
              ++index
              index = clamp(index)
              scope.options.selected = data[index]
            else
              scope.options.selected = data[0]
            return false
          else if event.which == keyKodes.arrows.up
            if selected
              index = data.indexOf(selected)
              --index
              index = clamp(index)
              scope.options.selected = data[index] 
            else
              scope.options.selected = data[data.length - 1]
            return false
          return true

            
            

