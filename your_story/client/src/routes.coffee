angular.module 'aiesec'
  .config ($stateProvider, $urlRouterProvider) ->
    # $urlRouterProvider.otherwise '/'

    story_form =
      name: 'story_form'
      url: ''
      abstract: true
      templateUrl: 'views/story_form.html'

    story_form_participant =
      name: 'story_form.participant',
      url: ''
      templateUrl: 'views/participant_form.html'
      controller: 'StoryFormController'

    $stateProvider
      .state(story_form)
      .state(story_form_participant)
