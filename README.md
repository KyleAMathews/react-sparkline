react-sparkline
===============

React component for rendering simple sparklines. Companion to [react-micro-bar-chart](https://github.com/KyleAMathews/react-micro-bar-chart).

## Install
`npm install react-sparkline`

## Usage
````javascript
var Sparkline = require('react-sparkline');

// Pass in an array of values.
<Sparkline data={anArrayOfValues} />

// Sparkline of dates + values
// Pass in an array of objects something like
values = [
  {
    date: "2014-06-23T00:21:59.271Z"
    value: 2
  },
  {
    date: "2014-06-24T00:21:59.271Z"
    value: 4
  }
]
<Sparkline data={values} />

````

## Demo
http://kyleamathews.github.io/react-sparkline/
