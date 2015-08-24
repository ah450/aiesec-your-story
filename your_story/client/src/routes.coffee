angular.module 'aiesec'
  .config ($stateProvider, $urlRouterProvider) ->
    storyForm =
      name: 'storyForm'
      url: ''
      abstract: true
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
      url: ''
      templateUrl: 'story_form/participant_form.html'
      controller: 'ParticipantFormController'

    storyMemberExtraForm =
      name: 'storyForm.memberExperience'
      url: 'experience'
      templateUrl: 'story_form/member_experience.html'
      controller: 'MemberExperienceController'

    storyFormStory = 
      name: 'storyForm.story'
      url: 'story'
      templateUrl: 'story_form/story_form.html'
      controller: 'StoryFormController'

    storyFormThankYou = 
      name: 'storyForm.thankYou'
      url: 'thanks'
      templateUrl: 'story_form/thank_you.html'
      resolve: 
        locations: (states) ->
          states
        $title: ->
          'Thank You!'

    $stateProvider
      .state(storyForm)
      .state(storyParticipantForm)
      .state(storyMemberExtraForm)
      .state(storyFormThankYou)
