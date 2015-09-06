angular.module 'aiesec'
  .controller 'StoryFormController', ($scope, $state, $q, $filter
    currentCreation, pTypes, endpoints) ->
    # Prepare form data objects
    $scope.storyFormData = {}
    $scope.statesSearchUrl = endpoints.states.search

    $scope.autoCompleteObjectSelected = (state)->
      if angular.isDefined state && state != null
        $ '#location'
          .addClass 'valid'
        $scope.storyFormData.state = state.originalObject
      else
        $ '#location'
          .removeClass 'valid'
        $scope.storyFormData.state = null

    $scope.autocompleteOk = ->
      state = $scope.storyFormData.state
      angular.isDefined(state) && state != null

    $scope.autoCompleteFocusIn = ->
      $ '#location'
      .addClass 'focused'
      return

    $scope.autoCompleteFocusOut = ->
      $ '#location'
        .removeClass 'focused'
        .removeClass 'pristine'
      if angular.isUndefined($scope.storyFormData.state) || $scope.storyFormData.state == null
        $scope.$broadcast 'angucomplete-alt:clearInput', 'location'
      return

    $scope.isMember = ->
      currentCreation.participant.getType() == "member_profile"

    $scope.issueApplicable = ->
      if not $scope.isMember()
        currentCreation.participant.getProfile().outgoing or
          currentCreation.participant.getType() == "talent_profile"
      else
        return false

    # Only global talent has a company field
    $scope.companyApplicable = ->
      currentCreation.participant.getType() == 'talent_profile'

    #  Define issues if applicable
    if $scope.issueApplicable()
      if currentCreation.participant.getType() == "citizen_profile"
        $scope.issues = ["Teaching", "Empowerment", "Awareness", "Volunteer"]
      else if currentCreation.participant.getType() == "talent_profile"
        $scope.issues = ["Teaching", "Management", "IT"]
    else
      $scope.issues = []
       

    $scope.experienceType = ->
      switch currentCreation.participant.getType()
        when "member_profile" then 'member'
        when "citizen_profile" then 'volunteering'
        when "talent_profile" then 'internship'
        else ''

    $scope.numWords = ->
      if $scope.storyFormData.highlight && $scope.storyFormData.highlight.length > 1
        $scope.storyFormData.highlight.trim().split(/\s+/).length
      else
        0

    $scope.currentMax = ->
      if $scope.numWords() >= 50
        100
      else
        50
     
    $scope.submitting = false
    $scope.processForm = ->
      return if $scope.submitting
      $scope.submitting = true
      # Wait on participant then create story
      currentCreation.participantPromise.then () ->
        story = currentCreation.participant.newStory()
        if $scope.issueApplicable()
          story.setIssueName $scope.storyFormData.issue
        if $scope.companyApplicable()
          story.setCompanyName $scope.storyFormData.company
        story.setDate $filter('date')( $scope.storyFormData.date,
          'dd/mm/yyyy')
        story.setTitle $scope.storyFormData.title
        story.setHighlight $scope.storyFormData.highlight
        story.setStateID $scope.storyFormData.state.id
        currentCreation.storyPromise = story.save()
        currentCreation.storyPromise.then () ->
          $state.go '^.thankYou'




    