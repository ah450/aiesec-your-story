describe 'configurations factory', () ->

  beforeEach () ->
    spyOn console, 'log'
    spyOn console, 'debug'
    spyOn console, 'error'

  beforeEach module 'aiesec'

  beforeEach inject (_configurations_) ->
    @configurations = _configurations_

  it 'should have a default token expiration property', () ->
    @configurations.then (config) ->
      expect(config).toContain 'default_token_exp'

  it 'should have an error messages property', () ->
    @configurations.then (config) ->
      expect(config).toContain 'error_messages'



