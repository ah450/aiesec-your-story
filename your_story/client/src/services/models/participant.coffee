angular.module 'aiesec'
  .factory 'Participant', ($resource, $q, Story, Model, endpoints) ->
    resourceDefaultParams =
      id: "@id"
    resourceActions =
      get:
        method: 'GET'
        cache: true
      query:
        method: 'GET'
        cache: true
        isArray: true
    _Resource = $resource endpoints.participants.resourceUrl, 
            resourceDefaultParams, resourceActions
    class Participant extends Model
      constructor: (resource, exists=true) ->
        super resource
        if exists
          @stories = (new Story story for story in @resource.stories)

      newStory: (story) ->
        story = _.extend(story, {participant_id: @resource.id})
        @stories.push(story)
        return story

      setLC: (localChapter) ->
        @resource.local_chapter = localChapter.id

      setLastName: (lname) ->
        @resource.last_name = lname

      setFirstName: (fname) ->
        @resource.first_name = fname

      setType: (pType) ->
        @resource.type = pType

      @getResource: () ->
        _Resource

      @findById: (id) ->
        resource = @getResource
        $q (resolve, reject) ->
          params =
            id: id
          success = (participant) ->
            resolve new Participant participant
            return
          failure = (response) ->
            console.log 'failed to find participant by id', id,
              response
            reject response
            return
          resource.get params, success, failure
          return 

      @all: () ->
        Model.allHelper {}, @getResource, @pluralName, (resource) ->
          new Participant resource

      @allNoPagination: () ->
        Model.allNoPaginationHelper params, @getResource,
          @pluralName, Participant

      @fromObject: (data) ->
        resource = @getResource()
        return new Participant(new resource(data), false)

      @pluralName: 'participants'


