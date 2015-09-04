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
        profileTypeOpts: (profileTypeOptions) ->
          profileTypeOptions
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
      views: {
        "formContent@storyForm":
          templateUrl: 'story_form/member_experience.html'
          controller: 'MemberExperienceController'
        "selectPanel@storyForm.memberExperience":
          templateUrl: 'widgets/select_panel.html'
          controller: 'SelectPanel'
      }

    storyFormStory =
      name: 'storyForm.story'
      url: '/story'
      views: {
        "formContent@storyForm":
          templateUrl: 'story_form/story_form.html'
          controller: 'StoryFormController'
        "storyBasic@storyForm.story":
          templateUrl: 'story_form/story/story_basic.html'
        "storyExtra@storyForm.story":
          templateUrl: 'story_form/story/story_extra.html'
      }
      resolve:
        locations: (states) ->
          states

    storyFormThankYou =
      name: 'storyForm.thankYou'
      url: '/thanks'
      views: {
        "formContent@storyForm":
          templateUrl: 'story_form/thank_you.html'
          controller: 'ThankYouController'
      }
      resolve:
        $title: ->
          'Thank You!'
        firstName: (currentCreation) ->
          currentCreation.participant.getFirstName()
        lastName: (currentCreation) ->
          currentCreation.participant.getLastName()

    $stateProvider
      .state(storyForm)
      .state(storyParticipantForm)
      .state(storyMemberExtraForm)
      .state(storyFormStory)
      .state(storyFormThankYou)
    $urlRouterProvider.otherwise '/share/info'
    $urlRouterProvider.when '/share', '/share/info'
