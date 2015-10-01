angular.module 'aiesec'
  .controller 'AdminParticipantsController', ($scope, lcs, pTypes, participantPages) ->
    $scope.hasPages = participantPages.totalPages > 1
    $scope.goPage = (num) ->
      $scope.currentPage = num
      $scope.loadingPage = true
      participantPages.page num
        .then (data) ->
          $scope.data = data
          $scope.loadingPage = false

    $scope.goPage 1
    $scope.pTypes = pTypes
