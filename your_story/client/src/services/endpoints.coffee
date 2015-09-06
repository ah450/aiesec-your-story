angular.module 'aiesec'
  .factory 'endpoints', (apiHost) ->
    endpoints =
      localChapters:
        index: [apiHost, 'local_chapters'].join '/'
      states:
        index: [apiHost, 'states'].join '/'
        search: [apiHost, 'states'].join('/') + '?query='
      stories:
        resourceUrl: [apiHost, 'participants',
          ':participant_id', 'stories', ':id'].join '/'
      participants:
        resourceUrl: [apiHost, 'participants', ':id']. join '/'
        avatars:
          show: [apiHost, 'participants', ':participant_id',
            'avatars', ':id'].join '/'
      configurations:
        index: [apiHost, 'configurations'].join '/'
      profileTypes:
        index: [apiHost, 'profile_types'].join '/'
      memberProfileTypes:
        index: [apiHost, 'member_profile_types'].join '/'
      builders:
        participants:
          avatar: (pid) ->
            [apiHost, 'participants', pid, 'avatars'].join '/'
      
