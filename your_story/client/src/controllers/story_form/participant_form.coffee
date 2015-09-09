# Main controller for first participant form
# Job is to create a participant, establish profile type
# (member, talent, citizen)
angular.module 'aiesec'
  .controller 'ParticipantFormController', ($scope, $state, Participant,
    currentCreation, lcs, pTypes, profileTypeOpts) ->
    # Create an empty Participant entry and prepare form data fields
    $scope.participant = Participant.fromObject {}
    $scope.participantFormData = {}
    $scope.submitting = false
    # Options for local chapter select
    $scope.lcOpts =
      data: lcs
      dataDisplay: (item) ->
        item.name if item
      title: 'Home LC in Egypt'
      dirty: false
      required: ->
        @dirty && angular.isUndefined @selected

    # Options for AIESEC experience type select
    $scope.profileOpts =
      data: profileTypeOpts
      dataDisplay: (item) ->
        item.label if item
      title: 'Select Experience'
      dirty: false
      required: ->
        @dirty && angular.isUndefined @selected

    # Preserve some state
    if currentCreation.selectedLc
      $scope.lcOpts.selected = currentCreation.selectedLc
    
    # Watch selected values

    $scope.$watch 'lcOpts.selected', (newValue) ->
      $scope.participant.setLC newValue if newValue

    $scope.$watch 'profileOpts.selected', (newValue) ->
      if newValue
        $scope.participant.setType newValue.type, newValue.outgoing

    # Watch input fields
    # keep participant up to date
    $scope.$watch 'participantFormData.fname', (newValue) ->
      $scope.participant.setFirstName newValue if newValue

    $scope.$watch 'participantFormData.lname', (newValue) ->
      $scope.participant.setLastName newValue if newValue


    # Send to memberExperience sibling state if user selected member type
    # Else send to story sibling state
    $scope.processForm = () ->
      return if $scope.submitting
      $scope.submitting = true
      $ 'body'
        .addClass 'animate-view'
      currentCreation.selectedLc = $scope.lcOpts.selected
      currentCreation.participant = $scope.participant
      if $scope.participant.getType() == pTypes.member_profile
        $state.go '^.memberExperience'
      else
        currentCreation.createParticipant()
        $state.go '^.story'
      

