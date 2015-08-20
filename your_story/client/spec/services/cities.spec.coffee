describe 'cities factory', () ->
  
  beforeEach () ->
    spyOn console, 'log'
    spyOn console, 'debug'
    spyOn console, 'error'

  beforeEach module 'aiesec'

  beforeEach inject (_cities_) ->
    @cities = _cities_

  it 'should be an array', () ->
    @cities.then (cities) ->      
      expect(cities).toBeArrayOfObjects()
  
  it 'should have a default_name', () ->
    @cities.then (cities) ->
      for city in cities
        expect(city).toContain 'default_name'

  it 'should have an id', () ->
    @cities.then (cities) ->
      for city in cities
        expect(city).toContain 'id'

  it 'should have a country', () ->
    @cities.then (cities) ->
      for city in cities
        expect(city).toContain 'country'


