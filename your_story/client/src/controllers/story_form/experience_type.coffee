# Helper controller for experience_type view
angular.module 'aiesec'
  .controller 'ExperinceTypeController', ($scope, $state, pTypes, currentCreation, memberProfileTypes) ->
    $scope.selected = false
    $scope.pTypes = pTypes
    $scope.currentlySelected = null
    $scope.outGoing = null
    $scope.profileOpts = {}

    selectMember = ->
      $scope.selected = true
      $scope.currentlySelected = pTypes.member_profile
      $scope.profileOpts.selected = true

    selectCitizen = ->
      $scope.selectedExperienceHuman = 'Volunteering'
      $scope.currentlySelected = pTypes.citizen_profile


    selectTalent = ->
      $scope.selectedExperienceHuman = 'Internship'
      $scope.currentlySelected = pTypes.talent_profile

    $scope.resetSelection = ->
      $scope.selected = false
      $scope.outGoing = null
      $scope.currentlySelected = null
      delete $scope.profileOpts.selected
      delete $scope.memberExpOpts.selected

    $scope.selectProfile = (type) ->
      if $scope.selected
        $scope.resetSelection()
      else
        switch type
          when pTypes.member_profile
            selectMember()
          when pTypes.citizen_profile
            selectCitizen()
          when pTypes.talent_profile
            selectTalent()
        $scope.selected = true

    $scope.selectoutGoing = ->
      $scope.outGoing = true
      $scope.profileOpts.selected = true
      $scope.memberExpOpts.selected = true

    $scope.selectInside = ->
      $scope.outGoing = false
      $scope.profileOpts.selected = true
      $scope.memberExpOpts.selected = true

    $scope.memberExpOpts =
      data: memberProfileTypes.reverse()
      dirty: false
      required: ->
        @dirty && angular.isUndefined @selected
      dataDisplay: (item) ->
        item.label if item
      title: 'Membership type'

    subitting = false

    $scope.processForm = ->
      return if submitting
      submitting = true
      switch $scope.currentlySelected
        when pTypes.member_profile
          $scope.participant.setType $scope.currentlySelected
          $scope.participant.setMemberType $scope.memberExpOpts.selected.value
        else
          $scope.participant.setType $scope.currentlySelected, $scope.outGoing
      currentCreation.participant = $scope.participant
      $state.go '^.story'


    