angular.module 'aiesec'
  .directive 'rippleEffect', ->
    directive =
      restrict: 'A',
      link: (scope, element, attrs) ->
        element.click (event) ->
          if element.find('.rippler').length == 0
            element.append "<span class='rippler'></span>"

          rippler = element.find '.rippler'

          rippler.removeClass 'animate'
          # set dimensions
          dimension = Math.max element.innerWidth(), element.innerHeight()
          rippler.css {height: dimension, width: dimension}
          # click coordinates
          x = event.pageX - element.offset().left - rippler.width()/2
          y = event.pageY - element.offset().top - rippler.height()/2

          # Adjust position and add class
          rippler.css {top: y + 'px', left: x + 'px'}
          rippler.addClass 'animate'

          