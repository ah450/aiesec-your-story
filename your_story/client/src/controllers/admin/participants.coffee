angular.module 'aiesec'
  .controller 'AdminParticipantsController', ($scope, lcs, pTypes, participantPages) ->
    $scope.hasPages = participantPages.totalPages > 1
    $scope.totalPages = participantPages.totalPages
    $scope.loadingPage = true
    $scope.goPage = (num) ->
      return if num < 1 or num > $scope.totalPages
      $scope.currentPage = num
      $scope.loadingPage = true
      participantPages.page num
        .then (data) ->
          $scope.data = data
          $scope.loadingPage = false
    $scope.goPage 1
    $scope.pTypes = pTypes
