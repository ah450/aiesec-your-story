angular.module 'aiesec', ['ui.router', 'ui.router.title', 'ui.validate',
  'aiesec-templates', 'satellizer']



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
  .config ($authProvider, apiHost) ->
    $authProvider.tokenPrefix = 'aiesec-sattelizer'
    $authProvider.httpInterceptor = true
    $authProvider.loginOnSignup = true
    $authProvider.baseUrl = apiHost
    $authProvider.storage = 'localStorage'


angular.module 'aiesec'
  .config ($urlMatcherFactoryProvider) ->
    $urlMatcherFactoryProvider.strictMode(false)

# Defines constants for use within our app.
angular.module 'aiesec'
  .constant 'apiHost', 'https://evaluator.in/api'
  .constant 'statusApi', 'wss://evaluator.in/status'
  .constant 'baseHost', 'https://evaluator.in'


# Run blocks

angular.module 'aiesec'
  .run ($rootScope) ->
    $rootScope.isNavActive = false