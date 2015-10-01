angular.module 'aiesec'
  .config ($stateProvider) ->
    
    admin =
      name: 'admin'
      templateUrl: 'admin/root.html'
      url: '/admin'
      abstract: true
      data:
        authRule: (userAuth) ->
          if userAuth.signedIn
            {
              allowed: true
            }
          else
            return {
              to: 'admin.login'
              params: {}
              allowed: false
            }
      resolve:
        lcs: (localChapters) ->
          localChapters
        pTypes: (profileTypes) ->
          profileTypes
        $title: ->
          'Admin Panel'

    adminLogin =
      name: 'admin.login'
      url: '/login'
      data:
        authRule: true
      resolve:
        $title: ->
          'Admin Login'
      views:
        'adminContent':
          templateUrl: 'admin/login.html'
          controller: 'AdminLoginController'

    participants =
      name: 'admin.participants'
      url: '/participants'
      resolve:
        participantPages: (Participant) ->
          Participant.all()
      views:
        'adminContent':
          templateUrl: 'admin/participants.html'
          controller: 'AdminParticipantsController'

    participant =
      name: 'admin.participant'
      url: '/participant/:participantID'
      resolve:
        participant: ($stateParams, Participant) ->
          Participant.findById $stateParams.participantID
      views:
        'adminContent':
          templateUrl: 'admin/participant.html'
          controller: 'AdminParticipantController'
    $stateProvider
      .state admin
      .state participants
      .state participant
      .state adminLogin

