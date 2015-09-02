angular.module 'aiesec'
  .filter 'wordCounter', ->
    f = (value) ->
        if value && value.length > 1
          value.trim().split(/\s+/).length
        else
          0