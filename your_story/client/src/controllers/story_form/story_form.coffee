angular.module 'aiesec'
  .controller 'StoryFormController', ($scope, $state, $q
    currentCreation, pTypes, locations) ->
     
    names = _.map locations, (item, index) ->
            otherNames = _.map item.names, (other) ->
              other.name
            _.flatten([item.default_name, otherNames]).join '~~~~'
      
    $scope.locations = _.map names, (name, index) ->
      searchObject=
        value: index
        label: name

    $scope.submitting = false

    $scope.storyFormData = {}
    $scope.storyFormData.state = {}

    $scope.fullname = currentCreation.participant.getFullName
    # Callbacks for autocomplete plugin
    $scope.stateRender = (state) ->
      state.label.split('~~~~')[0]

    $scope.stateSelect = (state) ->
      if angular.isDefined(state.value)
        $scope.storyFormData.state = locations[state.value]
      else
        $scope.storyFormData.state = null
      state.label.split('~~~~')[0]

    $scope.isMember = ->
      currentCreation.participant.getType() == "member_profile"

    $scope.issueApplicable = ->
      if not $scope.isMember()
        currentCreation.participant.getResourceProperty("profile").outgoing or
          currentCreation.participant.getType() == "talent_profile"
      else
        return false

    $scope.companyApplicable = ->
      currentCreation.participant.getType() == 'talent_profile'

    if $scope.issueApplicable()
      if currentCreation.participant.getType() == "citizen_profile"
        $scope.issues = ["Teaching", "Empowerment", "Awareness", "Volunteer"]
      else if currentCreation.participant.getType() == "talent_profile"
        $scope.issues = ["Teaching", "Management", "IT"]
       

    $scope.experienceType = ->
      switch currentCreation.participant.getType()
        when "member_profile" then 'member'
        when "citizen_profile" then 'volunteering'
        when "talent_profile" then 'internship'
        else ''

    $scope.processForm = ->
      # Create Story
      $scope.submitting = true
      console.log $scope, currentCreation
      story = currentCreation.participant.newStory()
      if $scope.issueApplicable()
        story.setIssueName $scope.storyFormData.issue
      if $scope.companyApplicable()
        story.setCompanyName $scope.storyFormData.company
      story.setDate $scope.storyFormData.date
      story.setTitle $scope.storyFormData.title
      story.setHighlight $scope.storyFormData.highlight
      story.setStateID $scope.storyFormData.state.id
      console.log story
      # $state.go '^.thankYou'




    