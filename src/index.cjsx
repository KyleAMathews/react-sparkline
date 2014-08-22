React = require 'react'
d3 = require 'd3'

module.exports = React.createClass
  x: null
  y: null
  path: null
  line: null

  getDefaultProps: ->
    return {
      width: 50
      height: 10
      strokeColor: 'black'
      strokeWidth: '0.5px'
      interpolate: 'basis'
      circleDiameter: 1.5
      data: [1,23,5,5,23,0,0,0,4,32,3,12,3,1,24,1,5,5,24,23] # Some semi-random data.
      animate: false
      maxDataPoints: 100
    }

  shouldComponentUpdate: ->
    false

  componentDidMount: ->
    @data = @props.data.slice()
    @renderSparkline()

  componentDidUpdate: ->
    if @props.animate# and @props.data.length > @props.maxDataPoints
      @data.push @props.data.pop()
      @data.shift()

  render: ->
    <div></div>

  calcData: ->
    if @props.animate
      @
    else
      @data = @props.data

  renderSparkline: () ->
    @x = x = d3.scale.linear().range([2, @props.width - 2])
    @y = y = d3.scale.linear().range([@props.height - 2, 2])

    #parseDate = d3.time.format("%b %d, %Y").parse

    @line = d3.svg.line()
      .interpolate(@props.interpolate)
      .x((d,i) -> x(i))
      .y((d) -> y(d))

    x.domain([0, @data.length])
    y.domain(d3.extent(@data))

    svg = d3.select(@getDOMNode())
      .append('svg')
      .attr('width', @props.width)
      .attr('height', @props.height)
      .append('g')
      #.attr("clip-path", "url(#clip)")

    svg.append("defs").append("clipPath")
        .attr("id", "clip")
      .append("rect")
        .attr("width", @props.width - (@props.width/@props.maxDataPoints))
        .attr("height", @props.height)

    @path = svg.append("g")
        .attr("clip-path", "url(#clip)")
      .append("path")
        .datum(@data)
        .attr('class', 'sparkline')
        .style('fill', 'none')
        .style('stroke', @props.strokeColor)
        .style('stroke-width', @props.strokeWidth)
        .attr('d', @line)

    console.log @path

    # Don't add circle if we're animating.
    unless @props.animate
      svg.append('circle')
        .attr('class', 'sparkcircle')
        .attr('cx', x(@data.length-1))
        .attr('cy', y(@data[@data.length - 1]))
        .attr('fill', 'red')
        .attr('stroke', 'none')
        .attr('r', @props.circleDiameter)

    if @props.animate
      @updateSparkline()

  updateSparkline: ->
    #console.log @data
    #console.log "I should update"
    #console.log @data.length
    #console.log @path
    @data.push @props.data.pop()

    @y.domain(d3.extent(@data))

    @path
        .attr("d", @line)
        .attr("transform", null)
      .transition()
        .duration(100)
        .ease("linear")
        .attr("transform", "translate(" + @x(-1) + ",0)")
        .each("end", @updateSparkline)

    if @props.maxDataPoints < @data.length
      @data.shift()
