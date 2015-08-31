angular.module 'aiesec'
  .config ($stateProvider, $urlRouterProvider) ->

    storyForm =
      name: 'storyForm'
      url: '/share'
      templateUrl: 'story_form/root.html'
      resolve:
        lcs: (localChapters) ->
          localChapters
        pTypes: (profileTypes) ->
          profileTypes
        mpTypes: (memberProfileTypes) ->
          memberProfileTypes
        $title: ->
          'AIESEC | Your Story'

    storyParticipantForm =
      name: 'storyForm.participant',
      url: '/info'
      views: {
        "selectPanel@storyForm.participant":
          templateUrl: 'widgets/select_panel.html'
          controller: 'SelectPanel'
        "formContent@storyForm":
          templateUrl: 'story_form/participant_form.html'
          controller: 'ParticipantFormController'
        "participantBasic@storyForm.participant":
          templateUrl: 'story_form/participant/participant_basic.html'
        "experienceType@storyForm.participant":
          templateUrl: 'story_form/participant/experience_type.html'
        }

    storyMemberExtraForm =
      name: 'storyForm.memberExperience'
      url: '/experience'
      templateUrl: 'story_form/member_experience.html'
      controller: 'MemberExperienceController'

    storyFormStory =
      name: 'storyForm.story'
      url: '/story'
      templateUrl: 'story_form/story_form.html'
      controller: 'StoryFormController'
      resolve:
        locations: (states) ->
          states
        participantPromise: (currentCreation) ->
          currentCreation.participantPromise

    storyFormThankYou =
      name: 'storyForm.thankYou'
      url: '/thanks'
      templateUrl: 'story_form/thank_you.html'
      resolve:
        $title: ->
          'Thank You!'

    $stateProvider
      .state(storyForm)
      .state(storyParticipantForm)
      .state(storyMemberExtraForm)
      .state(storyFormStory)
      .state(storyFormThankYou)
    $urlRouterProvider.otherwise '/share/info'
    $urlRouterProvider.when '/share', '/share/info'
