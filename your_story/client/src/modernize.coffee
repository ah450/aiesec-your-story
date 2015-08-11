$.getScript('polyfills/flexie.js') if not Modernizr.flexbox

if not Modernizr.input.required
  $.getScript('polyfills/jquery.h5validate.js').done ->
    $(document).ready ->
      $('form').h5Validate()

if not (Modernizr.input.placeholder and Modernizr.input.autofocus)
  $.getScript('polyfills/jquery.html5support.js').done ->
    $(document).ready ->
      $.placeholder() if not Modernizr.input.placeholder
      $.autofocus() if not Modernizr.input.autofocus

$.getScript('polyfills/css3-multi-column.js') if not Modernizr.csscolumns

if not Modernizr.cssfilters
  $.getScript('polyfills/filters/lib/cssParser.js').done ->
    $.getScript('polyfills/filters/lib/css-filters-polyfill.js')

if not Modernizr.csstransforms
  $.getScript('polyfills/transform/sylvester.js').done ->
    $.getScript('polyfills/transform/transformie.js')