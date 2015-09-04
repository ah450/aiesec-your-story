angular.module 'aiesec'
  .factory 'currentCreation', ()->
    creation =
      createParticipant: ->
        @participantPromise = @participant.save().then (participant) =>
          participant.createAvatar @avatar
          return
