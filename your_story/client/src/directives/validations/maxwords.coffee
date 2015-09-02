angular.module 'aiesecValidations'
  .directive 'maxwords', ->
    directive =
      require: 'ngModel',
      link: (scope, element, attrs, ctrl) ->
        maxwords = parseInt attrs.maxwords
        ctrl.$validators.maxwords = (modelValue, viewValue) ->
          return true if ctrl.$isEmpty(modelValue)
          return viewValue.trim().split(/\s+/).length <= maxwords
        
