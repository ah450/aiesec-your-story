angular.module 'aiesec'
  .factory 'localChapters', (getOrCache, endpoints) ->
    url = endpoints.localChapters.index
    getOrCache('localChapters', url, [], 'local_chapters')