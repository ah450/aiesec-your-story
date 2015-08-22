angular.module 'aiesec'
  .config ($stateProvider, $urlRouterProvider) ->
    # $urlRouterProvider.otherwise '/'

    storyForm =
      name: 'story_form'
      url: ''
      abstract: true
      templateUrl: 'views/story_form.html'
      resolve:
        lcs: (localChapters) ->
          localChapters
        pTypes: (profileTypes) ->
          profileTypes

    storyParticipantForm =
      name: 'story_form.participant',
      url: ''
      templateUrl: 'views/participant_form.html'
      controller: 'ParticipantFormController'

    $stateProvider
      .state(storyForm)
      .state(storyParticipantForm)
