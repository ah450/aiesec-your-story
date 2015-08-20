angular.module 'aiesec'
  .factory 'Participant', ($q, Story, Model) ->
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
      constructor: (resource) ->
        super resource
        @stories = (new Story story for story in @resource.stories)

      @getResource: () ->
        _Resource

      @findById: (id) ->
        $q (resolve, reject) ->
          resource = @getResource
          params =
            id: participant.id
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

      @newStory: (story) ->
        story = _.extend(story, {participant_id: @resource.id})
        @stories.push(story)
        return story 

      @all: () ->
        Model.allHelper {}, @getResource, @pluralName, (resource) ->
          new Participant resource

      @allNoPagination: () ->
        Model.allNoPaginationHelper params, @getResource,
          @pluralName, Participant

      @fromObject: (data) ->
        resource = @getResource()
        return new Participant(new resource data)

      @pluralName: 'participants'


