angular.module 'aiesec', ['ui.router', 'ui.router.title', 'ui.validate',
  'aiesec-templates', 'satellizer', 'LocalStorageModule']



# Configuration blocks.

angular.module 'aiesec'
  .config ->
    if typeof Array::remove isnt 'function'
      Array::remove = (element) ->
        index = @indexOf element
        if index > -1
          @splice index, 1
          return true
        else
          return false

angular.module 'aiesec'
  .config ($compileProvider) ->
    $compileProvider.debugInfoEnabled(false)

angular.module 'aiesec'
  .config (localStorageServiceProvider) ->
    localStorageServiceProvider.setPrefix('aiesec')

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
  .config ($urlMatcherFactoryProvider) ->
    $urlMatcherFactoryProvider.strictMode(false)

# Defines constants for use within our app.
angular.module 'aiesec'
  .constant 'apiHost', '/api'
  .constant 'baseHost', '/'


# Run blocks

angular.module 'aiesec'
  .run ($rootScope) ->
    $rootScope.isNavActive = false