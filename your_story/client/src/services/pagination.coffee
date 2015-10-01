angular.module 'aiesec'
  .factory 'Pagination', ($q) ->
    class Pagination
      constructor: (@resource, @pluralName, @params={}, @factory=_.identity, @pageSize=10,
        @currentPage=1, @totalPages=0,
        @data=[],
        @loaded=false) ->
      
      # Access element
      at: (index, page=@currentPage) ->
        $q (resolve, reject) =>
          if not @loaded or @currentPage != page
            @load page, resolve, reject, index
          else
            resolve @data[index]
        
      # Function used internally to load pages
      load: (page, resolve, reject, index) ->
        @loaded = false
        success = (page) =>
          @data = (@factory item for item in page[@pluralName])
          @currentPage = page['page']
          @totalPages = page['total_pages']
          @pageSize = page['page_size']
          @loaded = true
          if index
            resolve @data[index]
          else
            resolve @data
          return
        failure = @loadFailure.bind @, reject
        query =
          page: page,
          page_size: @pageSize
        _.extend query, @params
        @resource.query query, success, failure

      # Handels failure for load
      loadFailure: (reject, response) ->
        console.error 'failed to load page', @currentPage, 'for', @resource
        reject @data
        return

      # Sets the page
      page: (pageNum) ->
        $q (resolve, reject) =>
          if not @loaded or @currentPage != pageNum
            @load pageNum, resolve, reject
          else
            resolve @data
