angular.module 'aiesec'
  .factory 'Story', ($resource, $q, endpoints, Model) ->
    resourceDefaultParams =
      participant_id: "@story.participant_id"
      id: "@story.id"
    resourceActions =
      get:
        method: 'GET'
        cache: true
      query:
        method: 'GET'
        cache: true
        isArray: false
      update:
        method: 'PUT'
  
    _Resource = $resource endpoints.stories.resourceUrl,
            resourceDefaultParams, resourceActions
    class Story extends Model
      # resource must be an initialized instance of $resource
      constructor: (resource) ->
        super resource

      @getResource: () ->
        _Resource

      @findById: (participant, storyID) ->
        resource = @getResource()
        $q (resolve, reject) ->
          params =
            participant_id: participant.getID()
            id: storyID
          success = (story) ->
            resolve new Story story
            return
          failure = (response) ->
            console.error 'failed to find story by id', particiant, storyID,
              response
            reject response
            return
          resource.get params, success, failure
          return

      setResourceProperty: (name, value) ->
        if not @resource.story
          @resource.story = {}
        @resource.story[name] = value

      getResourceProperty: (name) ->
        if not @resource.story
          @resource.story = {}
        @resource.story[name]

      setDate: (value) ->
        @setResourceProperty 'date', value

      setDuration: (value) ->
        @setResourceProperty 'duration', value

      getDuration: ->
        @getResourceProperty 'duration'

      getDate: ->
        @getResourceProperty 'date'

      setHighlight: (value) ->
        @setResourceProperty 'highlight', value

      @property 'highlight',
        get: ->
          @getHighlight()
        set: (value) ->
          @modified = true
          @setHighlight value

      @property 'date',
        get: ->
          @getDate()
        set: (value) ->
          @modified = true
          @setDate value

      @property 'title',
        get: ->
         @getTitle()
        set: (value) ->
          @modified = true
          @setTitle value

      getTitle: ->
        @getResourceProperty 'title'
          .capitalize()

      getHighlight: ->
        @getResourceProperty 'highlight'

      setTitle: (value) ->
        @setResourceProperty 'title', value

      setStateID: (value) ->
        @setResourceProperty 'state_id', value

      setCompanyName: (value) ->
        company =
          name: value
        @setResourceProperty 'company_attributes', company

      setParticipantID: (value) ->
        @setResourceProperty 'participant_id', value

      setIssueName: (value) ->
        issue =
          name: value
        @setResourceProperty 'issue_attributes', issue
      
      # Returns a new pagination instance
      @all: (participant) ->
        params =
          participant_id: participant.getID()
        Model.allHelper params, @getResource(), @pluralName, (resource)->
          new Story resource

      @allNoPagination: (participant) ->
        params =
          participant_id: participant.getID()
        Model.allNoPaginationHelper params, @getResource(),
          @pluralName, Story

      # required for query requests
      @pluralName: 'stories'

      @fromObject: (data) ->
        resource = @getResource()
        return new Story(new resource data)



