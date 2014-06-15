'use strict'

dartsUi = new window.DartsUi document.getElementById('darts-ui')
dartsUi.setListener (score, ratio) ->
    console.log score + ', ' + ratio + ' = ' + score * ratio

dartsUi.hit(96)
dartsUi.hit(112)
