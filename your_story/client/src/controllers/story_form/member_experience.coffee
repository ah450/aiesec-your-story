angular.module 'aiesec'
  .controller 'MemberExperienceController', ($scope, currentCreation, $state,
    mpTypes) ->
    $scope.memberTypes = {}
    $scope.memberTypes["Member (Function, OC, R&S, etc..)"] =
      value: mpTypes.member
      id: "member"
    $scope.memberTypes["Team Leader (Function, OC, R&S, etc..)"] =
      value: mpTypes.team_leader
      id: "team_leader"
    $scope.memberTypes["LCVP"] =
      value: mpTypes.lcvp
      id: "lcvp"
    $scope.memberTypes["LCP"] =
      value: mpTypes.lcp
      id: "lcp"
    $scope.memberTypes["MCVP"] =
      value: mpTypes.mcvp
      id: "mcvp"
    $scope.memberTypes["MCP"] =
      value: mpTypes.mcp
      id: 'mcp'
    $scope.memberTypes["AI"] =
      value: mpTypes.ai
      id: 'ai'
    $scope.memberTypes["Facilitator"] =
      value: mpTypes.facilitator
      id: 'facilitator'
    $scope.memberTypes["Chair"] =
      value: mpTypes.chair
      id: 'chair'
    $scope.memberTypes["CEEDer"] =
      value: mpTypes.ceeder
      id: 'ceeder'
    $scope.memberTypes["Congress Comittee"] =
      value: mpTypes.congress_comittee
      id: 'congress_comittee'
    $scope.memberTypes["NST"] =
      value: mpTypes.nst
      id: 'nst'
    
    if currentCreation.memberShipExperienceFormValues
      $scope.memberShipExperienceFormValues =
        currentCreation.memberShipExperienceFormValues
    else
      $scope.memberShipExperienceFormValues =
        currentCreation.memberShipExperienceFormValues = {}

    $scope.processForm = () ->
      currentCreation.participant.setMemberType(
        $scope.memberShipExperienceFormValues.membershipType)
      currentCreation.createParticipant()
      $state.go '^.story'


