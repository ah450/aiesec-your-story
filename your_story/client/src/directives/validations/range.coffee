angular.module 'aiesecValidations'
  .directive 'range', ->
    directive =
      require: 'ngModel'
      scope:
        max: '=rangeMax'
        min: '=rangeMin'
      link: (scope, element, attrs, ctrl) ->
        max = parseInt scope.max
        min = parseInt scope.min
        ctrl.$validators.range = (modelValue, viewValue) ->
          return true if ctrl.$isEmpty modelValue
          value = parseInt viewValue
          return false if isNaN value
          return value <= max && value >= min