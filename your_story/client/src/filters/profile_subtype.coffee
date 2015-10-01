angular.module 'aiesec'
  .filter 'profileSubtype', (memberProfileTypes) ->
      # Setup member subtype map
      lookupTable = {}
      _.each memberProfileTypes, (entry) ->
        lookupTable[entry.value] = entry.label
      # Actual filter
      (input) ->
        if 'outgoing' of input
          if input['outgoing']
            "Abroad"
          else
            "In Egypt"
        else
          lookupTable[input.membership_typ]
