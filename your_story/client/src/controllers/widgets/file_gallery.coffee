# Controller for multi file upload image preview widget
angular.module 'aiesec'
  .controller 'FileGallery', ($scope) ->
    $scope.urls = []
    $scope.current = 0
    $scope.nextDisabled = true
    $scope.prevDisabled = true

    checkNextDisabled = ->
      length = $scope.urls.length
      $scope.nextDisabled = length == 0 or $scope.current == length - 1

    checkPrevDisabled = ->
      length = $scope.urls.length
      $scope.prevDisabled = length == 0 or $scope.current == 0

    checkDisabled = ->
      checkNextDisabled()
      checkPrevDisabled()
    

    $scope.next = ->
      if $scope.urls.length > 0
        $scope.current = ($scope.current + 1) % $scope.urls.length
      else
        $scope.current = 0
      checkDisabled()

    $scope.prev = ->
      --$scope.current
      if $scope.current < 0
        $scope.current = 0
      checkDisabled()

    $scope.$watch 'files', (files) ->
      oldUrls = $scope.urls
      $scope.urls = []
      $scope.current = 0
      if files
        $scope.urls = (URL.createObjectURL file for file in files)
      _.each oldUrls, URL.revokeObjectURL
      checkDisabled()

    $scope.$on '$destroy',  ->
      _.each $scope.urls, URL.revokeObjectURL