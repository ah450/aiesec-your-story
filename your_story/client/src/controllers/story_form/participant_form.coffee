# Main controller for first participant form
# Job is to create a participant, establish profile type
# (member, talent, citizen)
angular.module 'aiesec'
  .controller 'ParticipantFormController', ($scope, Participant,
    currentCreation, lcs) ->
    # Create an empty Participant entry and prepare form data fields
    $scope.participant = Participant.fromObject {}
    $scope.participantFormData = {}
    # Options for local chapter select
    $scope.lcOpts =
      data: lcs
      dataDisplay: (item) ->
        item.name if item
      title: 'Home LC in Egypt'
      dirty: false
      required: ->
        @dirty && angular.isUndefined @selected

    # Watch selected values

    $scope.$watch 'lcOpts.selected', (newValue) ->
      if newValue
        $scope.participant.setLC newValue

    # Watch input fields
    # keep participant up to date
    $scope.$watch 'participantFormData.fname', (newValue) ->
      $scope.participant.setFirstName newValue if newValue

    $scope.$watch 'participantFormData.lname', (newValue) ->
      $scope.participant.setLastName newValue if newValue
        
      

