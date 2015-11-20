angular.module 'aiesecValidations'
  .directive 'numberOnly', ->
    directive =
      require: 'ngModel'
      link: (scope, element, attrs, ctrl) ->
        ctrl.$validators.numberOnly = (modelValue, viewValue) ->
          return true if ctrl.$isEmpty modelValue
          if viewValue.match(/^[0-9]+$/) is null
            return false
          value = parseInt viewValue
          if isNan value
            return false
          else
            return true