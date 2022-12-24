const { randomInt, randomCN, binomial } = require("./random_tools");

nouns_list = [
  "ball",
  "hook",
  "art",
  "chain",
  "cherries",
  "position",
  "cushion",
  "snail",
  "kick",
  "room",
  "blood",
  "sheet",
  "lunch",
  "cook",
  "nail",
  "carpenter",
  "underwear",
  "rat",
  "crib",
  "motion",
  "home",
  "oil",
  "spring",
  "decision",
  "ring",
  "plough",
  "wave",
  "measure",
  "color",
  "scissors",
  "receipt",
  "kitty",
  "mint",
  "yard",
  "stream",
  "kittens",
  "bee",
  "spade",
  "dolls",
  "spoon",
  "deer",
  "rest",
  "attempt",
  "pleasure",
  "sugar",
  "spiders",
  "pan",
];

adjectives_list = [
  "alcoholic",
  "fancy",
  "well-off",
  "moaning",
  "hurried",
  "wacky",
  "spotty",
  "steadfast",
  "berserk",
  "hellish",
  "excellent",
  "loose",
  "damaging",
  "bawdy",
  "bent",
  "makeshift",
  "amused",
  "broad",
  "bright",
  "secretive",
  "aback",
  "melodic",
  "lying",
  "decisive",
  "romantic",
  "deserted",
  "hospitable",
  "fast",
  "habitual",
  "spectacular",
  "five",
  "elite",
  "frantic",
  "motionless",
  "steep",
  "thinkable",
  "innate",
  "supreme",
  "vast",
  "exclusive",
  "careless",
  "excited",
  "gifted",
  "aloof",
  "amazing",
  "ill-informed",
  "tremendous",
  "agonizing",
  "momentous",
  "three",
];

function team_faker(cities, countries, sponsors, championships, leagues) {
  var name =
    adjectives_list[randomInt(adjectives_list.length)] +
    " " +
    nouns_list[randomInt(nouns_list.length)];
  var kind = randomCN();
  var request_team =
    "INSERT INTO Team(name, kind) VALUES (?, ?);SET @last_team_id = LAST_INSERT_ID();";
  var values_team = [name, kind];

  if (kind == "club") {
    var city_id = cities[randomInt(cities.length)].id;
    var league_id = leagues[randomInt(leagues.length)].id;
    var request_CN =
      "INSERT INTO Club(team, city) VALUES (@last_team_id, ?); SET @last_club_id = LAST_INSERT_ID();";
    var values_CN = [city_id];

    var request_CL =
      "INSERT INTO LeagueLink(club, league) VALUES (@last_club_id, ?);";
    var values_CL = [league_id];
  } else if (kind == "national") {
    var country_id = countries[randomInt(countries.length)].id;
    var championship_id = championships[randomInt(championships.length)].id;
    var request_CN =
      "INSERT INTO National(team, country) VALUES (@last_team_id, ?); SET @last_national_id = LAST_INSERT_ID();";
    var values_CN = [country_id];

    var request_CL =
      "INSERT INTO ChampionshipLink(national, championship) VALUES (@last_national_id, ?);";
    var values_CL = [championship_id];
  }

  var request_sponsor = "";
  var values_sponsor = [];
  if (binomial(0.8)) {
    var sponsor = sponsors[randomInt(sponsors.length)];
    request_sponsor =
      "INSERT INTO SponsorLink(team, sponsor, amount) VALUES (@last_team_id, ?, ?);";
    values_sponsor = [sponsor.id, randomInt(1000000)];
  }

  var request = request_team.concat(request_CN, request_CL, request_sponsor);
  var values = values_team.concat(values_CN, values_CL, values_sponsor);

  return { request: request, values: values };
}

function teams_faker(
  cities,
  countries,
  sponsors,
  championships,
  leagues,
  number_teams
) {
  var request = "";
  var values = [];
  for (let i = 0; i < number_teams; i++) {
    var new_team = team_faker(
      cities,
      countries,
      sponsors,
      championships,
      leagues
    );
    request = request.concat(new_team.request);
    values = values.concat(new_team.values);
  }
  return { request: request, values: values };
}

module.exports = { team_faker, teams_faker };
