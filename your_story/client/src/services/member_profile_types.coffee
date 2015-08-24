angular.module 'aiesec'
  .factory 'memberProfileTypes', (getOrCache, endpoints) ->
    url = endpoints.memberProfileTypes.index
    getOrCache('memberProfileTypes', url, {})