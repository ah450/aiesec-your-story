angular.module 'aiesec'
  .config ($stateProvider) ->

    storyForm =
      name: 'storyForm'
      url: '/share'
      abstract: true
      templateUrl: 'story_form/root.html'
      resolve:
        lcs: (localChapters) ->
          localChapters
        pTypes: (profileTypes) ->
          profileTypes
        $title: ->
          'AIESEC | Your Story'

    storyParticipantForm =
      name: 'storyForm.participant',
      url: '/info'
      onExit: ->
        $ 'body'
          .addClass 'animate-view'
      views: {
        "formContent@storyForm":
          templateUrl: 'story_form/participant_form.html'
          controller: 'ParticipantFormController'
        "participantBasic@storyForm.participant":
          templateUrl: 'story_form/participant/participant_basic.html'
        "experienceType@storyForm.participant":
          templateUrl: 'story_form/participant/experience_type.html'
          controller: 'ExperinceTypeController'
      }

    storyFormStory =
      name: 'storyForm.story'
      url: '/story'
      onEnter: ->
        $ '.story-box'
          .addClass 'story'
      views: {
        "formContent@storyForm":
          templateUrl: 'story_form/story_form.html'
          controller: 'StoryFormController'
        "storyBasic@storyForm.story":
          templateUrl: 'story_form/story/story_basic.html'
        "storyExtra@storyForm.story":
          templateUrl: 'story_form/story/story_extra.html'
      }

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
      .state(storyFormStory)
      .state(storyFormThankYou)
