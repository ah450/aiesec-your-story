angular.module 'aiesec'
  .factory 'currentCreation', ()->
    creation =
      createParticipant: ->
        @participantPromise = @participant.save()
      createAvatars: ->
        @participantPromise.then (participant) =>
          participant.createAvatars @avatars
