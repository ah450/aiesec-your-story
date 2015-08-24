angular.module 'aiesec'
  .directive 'uiDatepicker', ->
    directive =
      restrict: 'A',
      require: '?ngModel'
      link: (scope, element, attrs, ngModel) ->
        config =
          dateFormat: 'yy-mm-dd'
          onClose: (dateText, instance)->
            return false if !ngModel
            ngModel.$setViewValue dateText
            return false
        element.datepicker config

        if ngModel
          ngModel.$render = () ->
            element.datepicker 'setDate', ngModel.$viewValue

        scope.$on 'destroy', ->
          element.datepicker 'destroy'
