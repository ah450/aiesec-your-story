angular.module 'aiesec'
  .factory 'cities', (getOrCache, endpoints) ->
    url = endpoints.states.index
    getOrCache('cities', url, [], 'cities')