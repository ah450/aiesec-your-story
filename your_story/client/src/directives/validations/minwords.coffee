angular.module 'aiesecValidations'
  .directive 'minwords', ->
    directive =
      require: 'ngModel',
      link: (scope, element, attrs, ctrl) ->
        minwords = parseInt attrs.minwords
        ctrl.$validators.minwords = (modelValue, viewValue) ->
          return true if ctrl.$isEmpty(modelValue)
          return viewValue.trim().split(/\s+/).length >= minwords
