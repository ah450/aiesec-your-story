describe 'localChapters factory', () ->
  beforeEach () ->
    spyOn console, 'log'
    spyOn console, 'debug'
    spyOn console, 'error'

  beforeEach module 'aiesec'

  beforeEach inject (_localChapters_) ->
    @localChapters = _localChapters_

  it 'should be an array', () ->
    @localChapters.then (chapters) ->
      expect(chapters).toBeArrayOfStrings()

  it 'should have an id', () ->
    @localChapters.then (chapters) ->
      expect(chapter).toContain 'id' for chapter in chapters

  it 'should have a name', () ->
    @localChapters.then (chapters) ->
      expect(chapter).toContain 'name' for chapter in chapters