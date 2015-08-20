angular.module 'aiesec'
  .factory 'configurations', (getOrCache, endpoints) ->
    getOrCache 'configurations', endpoints.configurations.index, null