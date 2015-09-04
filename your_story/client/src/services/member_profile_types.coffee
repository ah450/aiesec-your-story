# Presentation layer mapping of AIESEC member sub profile types
angular.module 'aiesec'
  .factory 'memberProfileTypes', () ->
    memberTypes = [
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