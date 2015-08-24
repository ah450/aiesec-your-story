angular.module 'aiesec'
  .controller 'StoryFormController', ($scope, $state,
    currentCreation, pTypes, locations) ->

    $scope.storyFormData = {}
    $scope.storyFormData.state = {}

    # Callbacks for autocomplete plugin
    $scope.stateRender = (state) ->
      state.default_name

    $scope.stateSelect = (state) ->
      $scope.locationSelected.state = state

    $scope.experienceType = () ->
      switch currentCreate.participant.getType
        when pTypes.member_profile then 'AIESEC member'
        when  pTypes.citizen_profile then 'volunteering'
        when pTypes.talent_profile then 'internship'
        else ''



    