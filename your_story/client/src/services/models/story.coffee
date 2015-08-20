angular.module 'aiesec'
  .factory 'Story', ($resource, $q, endpoints, Model) ->
    resourceDefaultParams =
      participant_id: "@participant_id"
      id: "@id"
    resourceActions =
      get: 
        method: 'GET'
        cache: true
      query:
        method: 'GET'
        cache: true
        isArray: true  
    _Resource = $resource endpoints.stories.resourceUrl, 
            resourceDefaultParams, resourceActions
    class Story extends Model
      # resource must be an initialized instance of $resource
      constructor: (resource) ->
        super resource

      @getResource: () ->
        _Resource

      @findById: (participant, storyID) ->
        $q (resolve, reject) ->
          resource = @getResource()
          params =
            participant_id: participant.id
            id: storyID
          success = (story) ->
            resolve new Story story
            return
          failure = (response) ->
            console.log 'failed to find story by id', particiant, storyID,
              response
            reject response
            return
          resource.get params, success, failure
          return
      
      # Returns a new pagination instance
      @all: (participant) ->
        params = 
          participant_id: participant.id
        Model.allHelper params, @getResource(), @pluralName, (resource)->
          new Story resource

      @allNoPagination: (participant) ->
        params = 
          participant_id: participant.id
        Model.allNoPaginationHelper params, @getResource(),
          @pluralName, Story

      # required for query requests
      @pluralName: 'stories'

      @fromObject: (data) ->
        resource = @getResource()
        return new Story(new resource data)



