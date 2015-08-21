describe 'getOrCache service', () ->

  beforeEach () ->
    spyOn console, 'log'
    spyOn console, 'debug'
    spyOn console, 'error'

  
  # beforeEach module 'LocalStorageModule'


  beforeEach module 'aiesec'

  beforeEach inject (_localStorageService_) ->
    @store = _localStorageService_
    spyOn(@store, 'get').and.callThrough;
    spyOn(@store, 'set').and.callThrough;

  beforeEach inject (_$http_) ->
    @http = _$http_
    spyOn(@http, 'get').and.callThrough()

  beforeEach inject (_endpoints_) ->
    @endpoints = _endpoints_

  beforeEach inject (_getOrCache_) ->
    @getOrCache = _getOrCache_( 'testGetOrCache' ,@endpoints.states.index, [],
      'cities').then () =>
        _getOrCache_( 'testGetOrCache' ,@endpoints.states.index, [],
          'cities')


  it 'should cache after first request', () ->
    @getOrCache.then () ->
      expect(@http.get.calls.length).toEqual 1
      expect(@store.get.calls.length).toEqual 2
      expect(@store.set.calls.length).toEqual 1 
