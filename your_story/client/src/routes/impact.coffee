angular.module 'aiesec'
  .config ($stateProvider) ->
    
    impact =
      name: 'impact'
      templateUrl: 'impact/root.html'
      controller: 'ImpactMapController'
      url: '/impact'

    $stateProvider
      .state impact

