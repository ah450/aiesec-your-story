angular.module 'aiesec'
  .factory 'UserAuth', ($auth, $q, configurations) ->
    class UserService
      constructor: ->
        
      @property 'signedIn',
        get: ->
          $auth.isAuthenticated()

      login: (info, expiration=configurations.default_token_exp) ->
        deferred = $q.defer()
        $auth.login _.extend info, {expiration: expiration}
          .then (response) ->
            deferred.resolve response
          .catch (response) ->
            deferred.reject response
        return deferred.promise

      logout: ->
        if @signedIn
          $auth.logout()
        
    return new UserService()
    