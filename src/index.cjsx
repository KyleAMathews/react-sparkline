React = require 'react'
d3 = require 'd3'

module.exports = React.createClass

  getDefaultProps: ->
    return {
      width: 100
      height: 16
      strokeColor: 'black'
      strokeWidth: '0.5px'
      interpolate: 'basis'
      circleDiameter: 1.5
      data: [1,23,5,5,23,0,0,0,4,32,3,12,3,1,24,1,5,5,24,23] # Some semi-random data.
    }

  componentDidMount: ->
    @renderSparkline()

  render: ->
    <div></div>

  renderSparkline: () ->
    data = @props.data.slice()
    x = d3.scale.linear().range([2, @props.width - 2])
    y = d3.scale.linear().range([@props.height - 2, 2])

    # react-sparkline allows you to pass in two types of data.
    # Data tied to dates and linear data. We need to change our line and x/y
    # functions depending on the type of data.

    # These are objects with a date key
    if data[0]?.date?
      # Convert dates into D3 dates
      data.forEach (d) -> d.date = d3.time.format.iso.parse(d.date)

      line = d3.svg.line()
        .interpolate(@props.interpolate)
        .x((d,i) -> x(d.date))
        .y((d) -> y(d.value))

      x.domain(d3.extent(data, (d) -> d.date))
      y.domain(d3.extent(data, (d) -> d.value))

      lastX = x(data[data.length - 1].date)
      lastY = y(data[data.length - 1].value)

    else
      line = d3.svg.line()
        .interpolate(@props.interpolate)
        .x((d,i) -> x(i))
        .y((d) -> y(d))

      x.domain([0, data.length])
      y.domain(d3.extent(data))

      lastX = x(data.length - 1)
      lastY = y(data[data.length - 1])

    svg = d3.select(@getDOMNode())
      .append('svg')
      .attr('width', @props.width)
      .attr('height', @props.height)
      .append('g')

    svg.append('path')
      .datum(data)
      .attr('class', 'sparkline')
      .style('fill', 'none')
      .style('stroke', @props.strokeColor)
      .style('stroke-width', @props.strokeWidth)
      .attr('d', line)

    svg.append('circle')
      .attr('class', 'sparkcircle')
      .attr('cx', lastX)
      .attr('cy', lastY)
      .attr('fill', 'red')
      .attr('stroke', 'none')
      .attr('r', @props.circleDiameter)
