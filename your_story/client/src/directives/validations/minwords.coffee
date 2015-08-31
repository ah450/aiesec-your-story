angular.module 'aiesecValidations'
  .directive 'minwords', ->
    directive =
      require: 'ngModel'
      link: (scope, element, attrs, ctrl) ->
        ctrl.$validators.minwords = (modelValue, viewValue) ->
          return true if ctrl.$isEmpty(modelValue)
          return viewValue.split(/\s+/).length >= attrs.minwords
