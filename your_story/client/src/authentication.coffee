# Authentication configuration

angular.module 'aiesec'
  .config ($authProvider, apiHost) ->
    $authProvider.tokenPrefix = 'aiesec-sattelizer'
    $authProvider.httpInterceptor = true
    $authProvider.loginOnSignup = true
    $authProvider.storage = 'localStorage'
    $authProvider.baseUrl = apiHost
    $authProvider.signupUrl = 'users'
    $authProvider.loginUrl = 'tokens'



angular.module 'aiesec'
  .run ($rootScope, $state, UserAuth, redirect) ->
    $rootScope.$on '$stateChangeStart', (e, toState, toParams) ->
      return if angular.isUndefined toState.data
      return if !angular.isFunction toState.data.authRule
      authStatus = toState.data.authRule UserAuth
      if !authStatus.allowed
        redirect.push {
          state: toState,
          params: toParams
        }
        e.preventDefault()
        $state.go authStatus.to, authStatus.params