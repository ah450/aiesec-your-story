angular.module 'aiesec'
  .factory 'profileTypes', (getOrCache, endpoints) ->
    url = endpoints.profileTypes.index
    getOrCache('profileTypes', url, [])