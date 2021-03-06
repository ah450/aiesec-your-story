angular.module 'aiesec'
  .controller 'StoryFormController', ($scope, $state, $q, $filter
    currentCreation, pTypes, endpoints) ->
    # Prepare form data objects
    $scope.integerval = /^\d*$/
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

    $scope.issueOpts =
      data: $scope.issues
      dataDisplay: (issue) ->
        issue
      dirty: false
      title: 'Issue...'
      required: ->
        @dirty && angular.isUndefined @selected

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
      250
     
    $scope.submitting = false

    $scope.processForm = ->
      return if $scope.submitting
      $scope.submitting = true
      # Wait on participant then create story
      currentCreation.createParticipant()
      currentCreation.participantPromise.then () ->
        promises = []
        promises.push $scope.createStory()
        promises.push $scope.createAvatars()
        $q.all promises
          .then () ->
            currentCreation.storyPromise.then () ->
              $state.go '^.thankYou'

    # Creates a story
    # and returns a promise
    $scope.createStory = ->
      story = currentCreation.participant.newStory()
      if $scope.issueApplicable()
        story.setIssueName $scope.issueOpts.selected
      if $scope.companyApplicable()
        story.setCompanyName $scope.storyFormData.company
      date = new Date $scope.storyFormData.year, $scope.storyFormData.month - 1
      story.setDate date.toDateString()
      story.setTitle $scope.storyFormData.title
      story.setHighlight $scope.storyFormData.highlight
      story.setStateID $scope.storyFormData.state.id
      story.setDuration $scope.storyFormData.duration
      currentCreation.storyPromise = story.save()

    # Creates an avatar
    # returna promise
    $scope.createAvatars = ->
      currentCreation.avatars = $scope.storyFormData.avatars
      currentCreation.createAvatars()




    