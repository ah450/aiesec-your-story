
$ document
  .click ()->
    $ '.lose-active'
      .removeClass 'active'
      # Do not use toggle
