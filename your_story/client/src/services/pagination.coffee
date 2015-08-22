angular.module 'aiesec'
  .factory 'Pagination', ($q) ->
    class Pagination
      constructor: (@resource, @pluralName, @pageSize=10,  @params={},
        @currentPage=1, @totalPages=0,
        @factory=_.identity, @data=[],
        @loaded=false) ->
      
      # Access element
      at: (index, page=@currentPage) ->
        $q (resolve, reject) =>
          if not @loaded or @currentPage != page
            @load page, resolve, reject, index
          else
            resolve data[index]
          return
        
      # Function used internally to load pages
      load: (page, resolve, reject, index) ->
        @loaded = false
        success = (page) ->
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
        console.log 'failed to load page', @currentPage, 'for', @resource
        reject @data
        return

      # Sets the page
      page: (pageNum) ->
        return @currentPage if not pageNum
        if @currentPage != pageNum
          $q (resolve, reject) ->
            if not @loaded or @currentPage != page
              @load page, resolve, reject
            else
              resolve data[index]
            return