angular.module 'aiesec'
  .controller 'AdminBannerController', ($scope, $state, UserAuth) ->

    $scope.logout = ->
      processing = true
      UserAuth.logout()
      $state.go 'admin.login'

    $scope.loggedIn = ->
      UserAuth.signedIn