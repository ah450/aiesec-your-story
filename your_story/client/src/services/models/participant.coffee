angular.module 'aiesec'
  .factory 'Participant', ($resource, $q, Upload, 
    Story, Avatar, Model, endpoints) ->
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

      setType: (pType, outgoing=null) ->
        @resource.profile_attributes = {}
        @resource.profile_attributes.outgoing = outgoing if outgoing != null
        @resource.type = pType

      setMemberType: (memberType) ->
        @resource.profile_attributes.membership_typ = memberValue

      getType: ()->
        @resource.type

      createAvatar: (file, progress) ->
        $q (resolve, reject) =>
          config =
            url: endpoints.builders.participants.avatar @resource.id
            method: 'POST'
            file: file
            fileFormDataName: 'avatar[data]'
          promise = Upload.upload config
          promise.progress progress if progress
          promise.then (data)->
            resolve Avatar.fromObject data
          promise.error (data, status, headers, config)->
            info = 
              data: data
              status: status
              headers: headers
              config: config
            reject info

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


