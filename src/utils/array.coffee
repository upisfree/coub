# Array
Array::first = ->
  this[0]

Array::last = ->
  this[this.length - 1]

# int only
Array::min = ->
  Math.min.apply null, this

Array::max = ->
  Math.max.apply null, this