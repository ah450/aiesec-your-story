angular.module 'aiesec'
  .factory 'Avatar', () ->
    class Avatar
      constructor: (@data) ->
      getUrl: ()->
        @data.url


