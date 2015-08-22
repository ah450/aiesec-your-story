angular.module 'aiesec'
  .factory 'endpoints', (apiHost) ->
    endpoints =
      localChapters:
        index: [apiHost, 'local_chapters'].join '/'
      states:
        index: [apiHost, 'states'].join '/'
      stories:
        resourceUrl = [apiHost, 'participants',
          ':participant_id', 'stories', ':id'].join '/'
      participants:
        resourceUrl = [apiHost, 'participants', ':id']. join '/'
      configurations:
        index: [apiHost, 'configurations'].join '/'
      profileTypes:
        index: [apiHost, 'profile_types'].join '/'
      
