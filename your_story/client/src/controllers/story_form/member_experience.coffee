angular.module 'aiesec'
  .controller 'MemberExperienceController', ($scope, currentCreation, $state,
    mpTypes) ->

    $scope.memberTypes = [
      {
        value: 'nst',
        label: 'NST'
      },
      {
        value: 'congress_comittee',
        label: 'Congress Comittee'
      },
      {
        value: 'ceeder',
        label: 'CEEDer'
      },
      {
        value: 'chair',
        label: 'Chair'
      },
      {
        value: 'facilitator',
        label: 'Facilitator'
      },
      {
        value: 'ai',
        label: 'AI'
      },
      {
        value: 'mcp',
        label: 'MCP'
      },
      {
        value: 'mcvp',
        label: 'MCVP'
      },
      {
        value: 'lcp',
        label: 'LCP'
      },
      {
        value: 'lcvp',
        label: 'LCVP'
      },
      {
        value: 'team_leader',
        label: 'Team Leader (Function, OC, R&S, etc..)'
      },
      {
        value: 'member',
        label: 'Member (Function, OC, R&S, etc..)'
      }
    ]

    $scope.expOpts =
      data: $scope.memberTypes
      dirty: false
      required: ->
        this.dirty && angular.isUndefined this.selected
      dataDisplay: (item) ->
        item.label if item
      title: 'Experience type'

    $scope.selectPanelOptions = $scope.expOpts
    $scope.submitting = false

    $scope.processForm = () ->
      return if $scope.submitting
      $scope.submitting = true
      currentCreation.participant.setMemberType(
        $scope.expOpts.selected.value)
      currentCreation.createParticipant()
      $state.go '^.story'


