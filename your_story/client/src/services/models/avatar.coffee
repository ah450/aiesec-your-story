angular.module 'aiesec'
  .factory 'Avatar', () ->
    class Avatar
      constructor: (@data) ->
      
      @property 'url',
        get: ->
          @data.url


