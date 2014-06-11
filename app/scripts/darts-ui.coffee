'use strict'

class DartsUi

    POINTS: [20, 1, 18, 4, 13, 6, 10, 15, 2, 17, 3, 19, 7, 16, 8, 11, 14, 9, 12, 5]
    FOCUS_CLASS: 'darts-focus'

    root: null

    centerX: null
    centerY: null
    radius: null

    focusedElement: null

    constructor: (element) ->
        @root = element
        @s = new Snap(@root)

        width = @root.clientWidth
        height = @root.clientHeight
        @centerX = width / 2
        @centerY = height / 2
        @radius = Math.min(@centerX, @centerY) * 0.95

        dartsUi = @draw()
        dartsUi.click @onClick

    draw: ->
        dartsUi = this.s.g();

        dartsUi.append(@drawCircle 'darts-base', 'base', this.radius)

        dartsUi.append(@drawRings 'darts-cell darts-high-ring', '2',   @radius * 0.75, @radius * 0.04)
        dartsUi.append(@drawRings 'darts-cell darts-single',    '1-o', @radius * 0.60, @radius * 0.25)
        dartsUi.append(@drawRings 'darts-cell darts-high-ring', '3',   @radius * 0.45, @radius * 0.04)
        dartsUi.append(@drawRings 'darts-cell darts-single',    '1-i', @radius * 0.25, @radius * 0.35)

        dartsUi.append(@drawCircle 'darts-cell darts-bull darts-bull-outer', '25-1', this.radius * 0.1)
        dartsUi.append(@drawCircle 'darts-cell darts-bull darts-bull-inner', '25-2', this.radius * 0.05)

        dartsUi.append(@drawPoints 'darts-point', @radius * 0.9, @radius * 0.1, '#fff')

        return dartsUi

    drawCircle: (className, key, radius) ->
        circle = this.s.circle @centerX, @centerY, radius
        circle.attr
            class: className
            id: key

        # this.cells[key] = circle

        return circle

    drawRings: (className, key, radius, strokeWidth) ->
        rings = @s.g()

        for i in [0..19]
            angle0 = (i * 18 - 9) * Math.PI / 180
            angle1 = (i * 18 + 9) * Math.PI / 180

            x0 = @centerX + radius * Math.sin angle0
            y0 = @centerY - radius * Math.cos angle0
            x1 = @centerX + radius * Math.sin angle1
            y1 = @centerY - radius * Math.cos angle1

            ring = this.s.path('M' + x0 + ' ' + y0 + ' A' + radius + ' ' + radius + ' 0 0 1 ' + x1 + ' ' + y1)
            ring.attr
                class: className
                strokeWidth: strokeWidth
                id: @POINTS[i] + '-' + key

            rings.append ring

            # this.cells[this.points[i] + '-' + key] = ring;

        return rings

    drawPoints: (className, radius) ->
        points = @s.g().attr {class: 'points'}

        for i in [0..19]
            angle = (i * 18) * Math.PI / 180
            x = @centerX + radius * Math.sin(angle)
            y = @centerY - radius * Math.cos(angle)
            point = @s.text x, y, @POINTS[i]
            point.attr
                class: className
                fontSize: (radius * 0.15) + 'px'

            height = point.getBBox().height
            point.attr
                dy: height / 2.8

            points.append point

        return points

    setListener: (listener) ->
        @listener = listener

    onClick: (event) =>
        @blur @focusedElement if @focusedElement?

        @focus event.target

        id = event.target.id
        [score, ratio] = id.split '-'

        return unless ratio?

        @listener? score, ratio

    focus: (element) =>
        element.classList.add @FOCUS_CLASS
        @focusedElement = element

    blur: (element) =>
        element.classList.remove @FOCUS_CLASS
        @focusedElement = null

window.DartsUi = DartsUi
