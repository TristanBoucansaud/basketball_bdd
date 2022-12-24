function randomInt(max_value) {
  return Math.floor(Math.random() * max_value);
}

function binomial(threshold) {
  return Math.random() <= threshold;
}

function randomCN() {
  return binomial(0.6) ? "club" : "national";
}

function randomDate() {
  var start = new Date(1980, 0, 1);
  var end = new Date(2005, 0, 1);
  return new Date(
    start.getTime() + Math.random() * (end.getTime() - start.getTime())
  );
}

function multipleRandoms(arr, num) {
  const shuffled = [...arr].sort(() => 0.5 - Math.random());

  return shuffled.slice(0, num);
}

module.exports = { randomInt, randomCN, binomial, randomDate, multipleRandoms };
