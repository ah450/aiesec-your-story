angular.module 'aiesec'
  .config ($urlRouterProvider) ->
    $urlRouterProvider.when '/admin', '/admin/participants'
    $urlRouterProvider.when '/share', '/share/info'
    $urlRouterProvider.when '', '/share'