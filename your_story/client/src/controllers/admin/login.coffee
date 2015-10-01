angular.module 'aiesec'
  .controller 'AdminLoginController', ($scope, $state, redirect,
    UserAuth, httpStatusCodes) ->
    $scope.processing = false
    $scope.userData = {}
    $scope.login = ->
      return if $scope.processing
      $scope.processing = true
      UserAuth.login $scope.userData, $scope.expiration
        .then ->
          if redirect.empty
            # Go to parent state
            $state.go '^.participants'
          else
            dest = redirect.pop()
            $state.go dest.state, dest.params
        .catch (response) ->
          if response.status == httpStatusCodes.UNAUTHORIZED
            $scope.processing = false
            $scope.error = "Invalid username or password"
          else
            $state.go 'errors.internal'


