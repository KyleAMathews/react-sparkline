React = require 'react'
d3 = require 'd3'

module.exports = React.createClass

  getDefaultProps: ->
    return {
      width: 50
      height: 10
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
    x = d3.scale.linear().range([2, @props.width - 2])
    y = d3.scale.linear().range([@props.height - 2, 2])

    #parseDate = d3.time.format("%b %d, %Y").parse

    line = d3.svg.line()
      .interpolate(@props.interpolate)
      .x((d,i) -> x(i))
      .y((d) -> y(d))

    x.domain([0, @props.data.length])
    y.domain(d3.extent(@props.data))

    svg = d3.select(@getDOMNode())
      .append('svg')
      .attr('width', @props.width)
      .attr('height', @props.height)
      .append('g')

    svg.append('path')
      .datum(@props.data)
      .attr('class', 'sparkline')
      .style('fill', 'none')
      .style('stroke', @props.strokeColor)
      .style('stroke-width', @props.strokeWidth)
      .attr('d', line)

    svg.append('circle')
      .attr('class', 'sparkcircle')
      .attr('cx', x(@props.data.length-1))
      .attr('cy', y(@props.data[@props.data.length - 1]))
      .attr('fill', 'red')
      .attr('stroke', 'none')
      .attr('r', @props.circleDiameter)
