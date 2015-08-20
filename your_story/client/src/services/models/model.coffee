angular.module 'aiesec'
  .factory 'Model', (Pagination, $q) ->
    class Model
      # Resource must be an initialized instance of $resource
      constructor: (@resource) ->

      # params is passed to Pagination instance
      # factory is passed to Pagination
      # Usually it's a function that constructs instances of 
      # a model subclass
      # Returns a pagination instance
      @allHelper: (params, resource, pluralName, factory) ->
        new Pagination resource, pluralName, params, factory

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
            console.log 'failed to fetch all without pagination', 
              pluralName, resource, res
            reject res
          resource.query params, success, failure
          return

      save: () ->
        @resource.$save()
