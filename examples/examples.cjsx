React = require('react')
Table = require 'react-simple-table'
faker = require 'faker'
Sparkline = require('../src/index')

columns = ['apple', 'peach', {
  displayName: 'activity'
  function: (data) -> <Sparkline data={data.data} />
}]

data = for i in [0..5]
  {
    apple: faker.Lorem.words(1)
    peach: faker.Lorem.words(1)
    data: for i in [0..50]
      faker.Helpers.randomNumber(20)
  }

module.exports = React.createClass
  getInitialState: ->
    currentSpeed: 0
    speeds: for i in [0..100]
      0

  componentDidMount: ->
    window.addEventListener 'mousemove', @handleMouseMove, false
    setInterval @calculateMouseSpeed, 50

  componentWillUnmount: ->
    window.removeEventListener 'mousemove', @handleMouseMove

  render: ->
    <div style={width:'400px', margin:'0 auto'}>
      <h1>React-Sparkline</h1>
      <a href="https://github.com/KyleAMathews/react-sparkline">Code on Github</a>
      <br />
      <br />

      <h2>Default look</h2>
      <pre><code>
      {"""
      <Sparkline />
        """}
      </code></pre>
      <Sparkline />

      <h2>Track mouse speed</h2>
      <pre><code>
      {"""
      <Sparkline />
        """}
      </code></pre>
      <Sparkline
        animate
        data={@state.speeds}
        width=500
        height=50
      />

      <h2>Override all defaults</h2>
      <pre><code>
      {"""
      <Sparkline
        width=200
        height=40
        strokeColor='green'
        strokeWidth='5px'
        interpolate='none'
        circleDiameter=10 />
        """}
      </code></pre>
      <Sparkline
        width=300
        height=40
        strokeColor='green'
        strokeWidth='5px'
        interpolate='none'
        circleDiameter=10 />
      <br />

      <h2>Pass in data</h2>
      <pre><code>
      {"""
      <Sparkline
        data={[48999,89163,60000,99526,89736,89963,97176]}
        width=200
        height=20
        />
        """}
      </code></pre>
      <Sparkline
        data={[48999,89163,60000,99526,89736,89963,97176]}
        width=200
        height=20
        />
      <br />

      <h2>Use in table</h2>
      <Table columns={columns} data={data} />
      <br />
      <br />
      <br />
      <br />

    </div>

  handleMouseMove: (e) ->
    @currentX = e.screenX
    @currentY = e.screenY

  calculateMouseSpeed: ->
    #console.log 'hi', @
    if @lastX and @lastY
      traveledX = @currentX - @lastX
      traveledY = @currentY - @lastY
      currentSpeed = Math.sqrt(Math.pow(traveledX, 2) + Math.pow(traveledY, 2))
      #console.log @state
      @setState {
        currentSpeed: currentSpeed
        speeds: @state.speeds.concat currentSpeed
      }

    @lastX = @currentX
    @lastY = @currentY
