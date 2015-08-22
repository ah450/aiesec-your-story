angular.module 'aiesec'
  .factory 'states', (getOrCache, endpoints) ->
    url = endpoints.states.index
    getOrCache('states', url, [], 'states')