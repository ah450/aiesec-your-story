angular.module 'aiesec'
  .factory 'Animation', ->
    class Animation
      constructor: (transitionFunction, startValue, targetValue, @duration,
        @applyFunc) ->
        @tf = _.partial $.easing[transitionFunction], null, _, startValue,
          targetValue, @duration
        @ranOnce = false

      register: (currentTime) ->
        @startTime = currentTime

      animate: (currentTime) ->
        @ranOnce = true
        @applyFunc @tf currentTime - @startTime

      running: (currentTime) ->
        currentTime - @startTime < @duration or not @ranOnce


      
    