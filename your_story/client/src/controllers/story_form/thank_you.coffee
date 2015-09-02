angular.module 'aiesec'
  .controller 'ThankYouController', ($scope, currentCreation, firstName, lastName) ->
    $scope.firstName = firstName
    $scope.lastName = lastName
    $scope.done = false

    currentCreation.storyPromise.then ->
      $scope.done = true
