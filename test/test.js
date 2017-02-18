function add(x, y) {
  return x + y;
}

window.add = add

if (module) {
  module.exports = add
}