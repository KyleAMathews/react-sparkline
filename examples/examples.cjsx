React = require('react')
Table = require 'react-simple-table'
faker = require 'faker'
Sparkline = require('../src/index')
_ = require 'underscore'

columns = ['apple', 'peach', {
  displayName: 'activity'
  function: (data) -> <Sparkline data={data.data} />
}]

data = for i in [0..5]
  {
    apple: faker.lorem.words(1)
    peach: faker.lorem.words(1)
    data: for i in [0..50]
      faker.helpers.randomNumber(20)
  }

dateData = for i in [0..100]
  {
    date: faker.date.between("2014-06-23T00:21:59.271Z", "2014-07-23T00:21:59.271Z")
    value: faker.helpers.randomNumber(100)
  }

dateData = _.sortBy dateData, (datum) -> return datum.date

module.exports = React.createClass
  render: ->
    <div style={width:'500px', margin:'0 auto'}>
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

      <h2>Pass in non-date data</h2>
      <pre style={"white-space":"pre-wrap"}><code>
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

      <h2>Pass in date data</h2>
      <pre style={"white-space":"pre-wrap"}><code>
      {"""
      dateData = for i in [0..100]
        {
          date: faker.date.between("2014-06-23T00:21:59.271Z", "2014-07-23T00:21:59.271Z")
          value: faker.helpers.randomNumber(100)
        }

      dateData = _.sortBy dateData, (datum) -> return datum.date

      <Sparkline
        data={dateData}
        width=200
        height=20
        />
        """}
      </code></pre>
      <Sparkline
        data={dateData}
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

      <h2>If no data is passed in, an empty div is returned</h2>
      <pre style={"white-space":"pre-wrap"}><code>
        {"<Sparkline data={[]} />"}
      </code></pre>
      <Sparkline data={[]} />

    </div>
