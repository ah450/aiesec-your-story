# Controller for member experience view.
# Trigerred if user selects AIESEC member as profile type
# Purpose is to establish sub profile type
angular.module 'aiesec'
  .controller 'MemberExperienceController', ($scope, currentCreation, $state, memberProfileTypes) ->

    $scope.memberTypes = memberProfileTypes

    $scope.expOpts =
      data: $scope.memberTypes
      dirty: false
      required: ->
        @dirty && angular.isUndefined @selected
      dataDisplay: (item) ->
        item.label if item
      title: 'Experience type'

    $scope.selectPanelOptions = $scope.expOpts
    $scope.submitting = false

    $scope.processForm = () ->
      return if $scope.submitting
      $scope.submitting = true
      currentCreation.participant.setMemberType(
        $scope.expOpts.selected.value)
      currentCreation.createParticipant()
      $state.go '^.story'


