angular.module 'aiesec'
  .directive 'maxwords', ->
    directive =
      require: 'ngModel'
      link: (scope, element, attrs, ctrl) ->
        ctrl.$validators.maxwords = (modelValue, viewValue) ->
          return true if ctrl.$isEmpty(modelValue)
          return viewValue.split(/\s+/).length <= attrs.maxwords
