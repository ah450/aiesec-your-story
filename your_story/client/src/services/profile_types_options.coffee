# Presentation layer maping of profile type options to server understood values
angular.module 'aiesec'
  .service 'profileTypeOptions', (profileTypes)->
    profileTypes.then (pTypes) ->
      profileTypeOpts = []
      profileTypeOpts.push
        label: "AIESEC Member"
        type: pTypes.member_profile
        id: "aiesecMemberOpt"
      

      profileTypeOpts.push
        label: "Volunteering Abroad"
        type: pTypes.citizen_profile
        outgoing: true
        group: 'Global Citizen'
        id: "globalCitizenOutOpt"
      

      profileTypeOpts.push
        label: "Volunteering in Egypt"
        type: pTypes.citizen_profile
        outgoing: false
        group: 'Global Citizen'
        id: "globalCitizenInOpt"

      profileTypeOpts.push
        label: 'Internship Abroad'
        type: pTypes.talent_profile
        outgoing: true
        group: 'Global Talent'
        id: "globalTalentOutOpt"

      profileTypeOpts.push
        label: 'Internship in Egypt'
        type: pTypes.talent_profile
        outgoing: false
        group: 'Global Talent'
        id: "globalTalenInOpt"
      return profileTypeOpts
