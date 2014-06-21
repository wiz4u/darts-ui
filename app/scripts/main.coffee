'use strict'

dartsUi = document.getElementById('darts-ui')
dartsUi.addEventListener 'hit', (data) ->
    {score, ratio} = data.detail
    console.log score + ', ' + ratio + ' = ' + score * ratio

# dartsUi.hit(96)
# dartsUi.hit(112)
