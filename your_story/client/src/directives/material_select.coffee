angular.module 'aiesec'
  .directive 'materialSelect', ->
    directive =
      restrict: 'AE',
      templateUrl: 'widgets/select_panel.html',
      scope:
        options: '='
      controller: 'SelectPanel'

