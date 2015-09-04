# Presentation layer maping of profile type options to server understood values
angular.module 'aiesec'
  .service 'profileTypeOptions', (profileTypes)->
    profileTypes.then (pTypes) ->
      profileTypeOpts = {}
      profileTypeOpts["AIESEC Member"] =
        type: pTypes.member_profile
        id: "aiesecMemberOpt"

      profileTypeOpts["Volunteering Abroad"] =
        type: pTypes.citizen_profile
        outgoing: true
        group: 'Global Citizen'
        id: "globalCitizenOutOpt"

      profileTypeOpts["Volunteering in Egypt"] =
        type: pTypes.citizen_profile
        outgoing: false
        group: 'Global Citizen'
        id: "globalCitizenInOpt"

      profileTypeOpts['Internship Abroad'] =
        type: pTypes.talent_profile
        outgoing: true
        group: 'Global Talent'
        id: "globalTalentOutOpt"

      profileTypeOpts['Internship in Egypt'] =
        type: pTypes.talent_profile
        outgoing: false
        group: 'Global Talent'
        id: "globalTalenInOpt"
      return profileTypeOpts
