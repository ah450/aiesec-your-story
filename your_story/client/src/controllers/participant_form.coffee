angular.module 'aiesec'
  .controller 'ParticipantFormController', ($scope, Participant, states, lcs, pTypes) ->
    $scope.participant = Participant.fromObject {}
    $scope.lcOpts =
      data: lcs
      dataDisplay: (item) ->
        item.name if item
      title: 'Local Chapter'
    $scope.participantFormData = {}

    $scope.profileTypeOpts = {}
    $scope.profileTypeOpts["AIESEC Member"] =
      type: pTypes.member_profile

    $scope.profileTypeOpts["Volunteering Abroad"] =
      type: pTypes.citizen_profile
      outgoing: true
      group: 'Global Citizen'

    $scope.profileTypeOpts["Volunteering in Egypt"] =
      type: pTypes.citizen_profile
      outgoing: false
      group: 'Global Citizen'

    $scope.profileTypeOpts['Internship Abroad'] =
      type: pTypes.talent_profile
      outgoing: true
      group: 'Global Talent'

    $scope.profileTypeOpts['Internship in Egypt'] =
      type: pTypes.talent_profile
      outgoing: false
      group: 'Global Talent'

    $scope.profileData = {}

    $scope.$watch 'lcOpts.selected', (newValue) ->
      $scope.participant.setLC newValue if newValue

    $scope.$watch 'participantFormData.fname', (newValue) ->
      $scope.participant.setFirstName newValue if newValue

    $scope.$watch 'participantFormData.lname', (newValue) ->
      $scope.participant.setLastName newValue if newValue

    $scope.$watch 'profileData.profileType', (newValue) ->
      if newValue
        $scope.participant.setType newValue.type