angular.module 'aiesec'
  .controller 'AdminParticipantController', ($scope, participant, pTypes) ->
    $scope.pTypes = pTypes
    $scope.participant = participant
    $scope.story = participant.stories[0]
    $scope.canSave = ->
      return $scope.story.modified

    currentIndex = 0

    $scope.save = ->
      $scope.saving = true
      $scope.story.update().then ->
        $scope.saving = false

    $scope.prevImage = ->
      figures = $ '.avatars-gallery figure'
      figures.eq(currentIndex).removeClass 'active'
      --currentIndex
      currentIndex = participant.avatars.length - 1 if currentIndex < 0
      figures.eq(currentIndex).addClass 'active'
      return

    $scope.nextImage = ->
      figures = $ '.avatars-gallery figure'
      figures.eq(currentIndex).removeClass 'active'
      currentIndex = (currentIndex + 1) % participant.avatars.length
      figures.eq(currentIndex).addClass 'active'
      return
