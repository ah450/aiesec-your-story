angular.module 'aiesec'
  .factory 'endpoints', (apiHost) ->
    endpoints =
      localChapters:
        index: [apiHost, 'local_chapters.json'].join '/'
      states:
        index: [apiHost, 'states.json'].join '/'
        search: [apiHost, 'states.json'].join('/') + '?query='
      stories:
        resourceUrl: [apiHost, 'participants',
          ':participant_id', 'stories', ':id.json'].join '/'
      participants:
        resourceUrl: [apiHost, 'participants', ':id.json']. join '/'
        avatars:
          show: [apiHost, 'participants', ':participant_id',
            'avatars', ':id.json'].join '/'
      configurations:
        index: [apiHost, 'configurations.json'].join '/'
      profileTypes:
        index: [apiHost, 'profile_types.json'].join '/'
      memberProfileTypes:
        index: [apiHost, 'member_profile_types.json'].join '/'
      builders:
        participants:
          avatar: (pid) ->
            [apiHost, 'participants', pid, 'avatars.json'].join '/'
      
