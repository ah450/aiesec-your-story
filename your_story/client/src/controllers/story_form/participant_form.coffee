# Main controller for first participant form
# Job is to create a participant, establish profile type
# (member, talent, citizen)
# and create avatar
angular.module 'aiesec'
  .controller 'ParticipantFormController', ($scope, $state, Participant,
    currentCreation, lcs, pTypes, profileTypeOpts) ->
    $scope.participant = Participant.fromObject {}
    $scope.participantFormData = {}
    $scope.lcOpts =
      data: lcs
      dataDisplay: (item) ->
        item.name if item
      title: 'Local Chapter'
      dirty: false
      required: ->
        this.dirty && angular.isUndefined this.selected
    
    $scope.selectPanelOptions = $scope.lcOpts
    $scope.submitting = false

    if currentCreation.selectedLc
      $scope.lcOpts.selected = currentCreation.selectedLc
    
    $scope.profileTypeOpts = profileTypeOpts

    $scope.profileData = {}

    $scope.$watch 'lcOpts.selected', (newValue) ->
      $scope.participant.setLC newValue if newValue

    $scope.$watch 'participantFormData.fname', (newValue) ->
      $scope.participant.setFirstName newValue if newValue

    $scope.$watch 'participantFormData.lname', (newValue) ->
      $scope.participant.setLastName newValue if newValue

    $scope.$watch 'profileData.profileOpts', (newValue) ->
      if newValue
        $scope.participant.setType newValue.type, newValue.outgoing

    # Send to memberExperience sibling state if user selected member type
    # Else send to story sibling state
    $scope.processForm = () ->
      return if $scope.submitting
      $scope.submitting = true
      $ 'body'
        .addClass 'animate-view'
      currentCreation.selectedLc = $scope.lcOpts.selected
      currentCreation.participant = $scope.participant
      currentCreation.avatar = $scope.participantFormData.avatar
      if $scope.participant.getType() == pTypes.member_profile
        $state.go '^.memberExperience'
      else
        currentCreation.createParticipant()
        $state.go '^.story'
      

