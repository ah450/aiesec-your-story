angular.module 'aiesec'
  .factory 'Participant', ($resource, $q, Upload,
    Story, Avatar, Model, endpoints) ->
    resourceDefaultParams =
      id: "@participant.id"
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
        else
          @stories = []

      newStory: () ->
        story = Story.fromObject {}
        story.setParticipantID @getID()
        @stories.push(story)
        return story

      setResourceProperty: (name, value) ->
        if not @resource.participant
          @resource.participant = {}
        @resource.participant[name] = value

      getResourceProperty: (name) ->
        if not @resource.participant
          @resource.participant = {}
        @resource.participant[name]

      getID: () ->
        @getResourceProperty 'id'

      setLC: (localChapter) ->
        @setResourceProperty 'local_chapter', localChapter.id

      setLastName: (lname) ->
        @setResourceProperty 'last_name', lname

      setFirstName: (fname) ->
        @setResourceProperty 'first_name', fname

      getLastName: ->
        @getResourceProperty 'last_name'

      getFirstName: ->
        @getResourceProperty 'first_name'

      getFullName: ->
        [@getFirstName(), @getLastName()].join ' '

      setType: (pType, outgoing=null) ->
        profile_attributes = {}
        profile_attributes.outgoing = outgoing if outgoing != null
        @setResourceProperty 'profile_attributes', profile_attributes
        @setResourceProperty 'profile_type', pType

      setMemberType: (memberType) ->
        attrs = @getResourceProperty 'profile_attributes'
        attrs.membership_typ = memberType

      getType: ()->
        @getResourceProperty 'profile_type'

      createAvatar: (file, progress) ->
        $q (resolve, reject) =>
          config =
            url: endpoints.builders.participants.avatar @resource.participant.id
            method: 'POST'
            file: file
            fileFormDataName: 'avatar[data]'
          promise = Upload.upload config
          promise.progress progress if progress
          promise.then (data)->
            resolve new Avatar data
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
        namespacedData =
          participant: data
        return new Participant(new resource(namespacedData), false)

      @pluralName: 'participants'


