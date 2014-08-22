React = require('react')
Sparkline = require('../src/index')
Table = require 'react-simple-table'
faker = require 'faker'


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

pizza = (
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

    <h2>Override all defaults</h2>
    <pre><code>
    {"""
    <Sparkline
      width=200
      height=40
      fill='rgb(63, 159, 215)'
      strokeColor='purple'
      strokeWidth='2px'
      interpolate='none'
      circleDiameter=5 />
      """}
    </code></pre>
    <Sparkline
      width=200
      height=40
      fill='rgb(63, 159, 215)'
      strokeColor='purple'
      strokeWidth='2px'
      interpolate='none'
      circleDiameter=5 />
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
)

React.renderComponent(pizza, document.body)
