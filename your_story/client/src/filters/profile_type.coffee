angular.module 'aiesec'
  .filter 'profileType', ->
    (input, pTypes) ->
      switch input
        when pTypes.member_profile
          "AIESEC member"
        when pTypes.talent_profile
          "Internship"
        else
          "Volunteer"
