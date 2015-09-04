# This service fetches the profile types from the api
# The profile types here are not meant for presentation it's simply a map
# to server understood values ie {member_profile: 0} meaning 0 is the value
# understood by the server for a member profile.
angular.module 'aiesec'
  .factory 'profileTypes', (getOrCache, endpoints) ->
    url = endpoints.profileTypes.index
    getOrCache('profileTypes', url, [])