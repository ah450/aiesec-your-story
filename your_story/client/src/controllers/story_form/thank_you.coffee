angular.module 'aiesec'
  .controller 'ThankYouController', ($scope, firstName, lastName) ->
    $scope.firstName = firstName
    $scope.lastName = lastName
