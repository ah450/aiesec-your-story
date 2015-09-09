angular.module 'aiesec'
  .controller 'SelectPanel', ($scope)->
    $scope.select = (item) ->
      $scope.options.selected = item

    $scope.getValue = ->
      if $scope.options.selected
        $scope.options.dataDisplay $scope.options.selected
      else
        $scope.options.title

    $scope.display = (item) ->
      $scope.options.dataDisplay item
    
    $scope.isSelected = ->
      angular.isDefined($scope.options.selected) && $scope.options.selected != null

    $scope.$on 'toggled', ->
      $scope.options.dirty = true