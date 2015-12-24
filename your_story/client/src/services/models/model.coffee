angular.module 'aiesec'
  .factory 'Model', (Pagination, $q) ->
    class Model
      # Resource must be an initialized instance of $resource
      constructor: (@resource) ->
        @modified = false

      # params is passed to Pagination instance
      # factory is passed to Pagination
      # Usually it's a function that constructs instances of
      # a model subclass
      # Returns a pagination instance
      @allHelper: (params, resource, pluralName, factory, paginationArgs...) ->
        pagination = new Pagination resource, pluralName, params,
          factory, paginationArgs...
        success = ->
          return pagination
        failure = (reason) ->
          console.error 'failed to load pagination', pagination
          return reason
        pagination.page(1).then success, failure

      # klass is the class to construct, usually a subclass
      # Returns a promise
      @allNoPaginationHelper: (params, resource,
        pluralName, klass) ->
        $q (resolve, reject) ->
          success = (res) ->
            resolve _.map res, (item) ->
              new klass item
            return
          failure = (res) ->
            console.error 'failed to fetch all without pagination',
              pluralName, resource, res
            reject res
          resource.query params, success, failure
          return

      save: ->
        $q (resolve, reject) =>
          success = (res) =>
            @exists = true
            resolve @
            return
          failure = (res) =>
            console.error 'failed to save model'
            console.error res, @
            reject res
          @resource.$save success, failure
          return

      delete: ->
        $q (resolve, reject) =>
          success = ->
            resolve null
          failure = (res) =>
            console.error 'failed to delete model'
            console.error res, @
            reject res
          @resource.$delete success, failure

      update: ->
        @modified = false
        $q (resolve, reject) =>
          success = (res) =>
            resolve @
          failure = (res) =>
            console.error 'failed to update model', res, @
            reject res
          @resource.update success, failure

