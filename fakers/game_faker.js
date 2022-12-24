const { binomial, multipleRandoms, randomInt } = require("./random_tools");

function parse_teams(nationals, clubs, championshiplinks, leaguelinks) {
  var championships = {};
  var leagues = {};
  for (let i = 0; i < championshiplinks.length; i++) {
    const link = championshiplinks[i];
    var championship_id = link.championship;
    var national = nationals.filter((n) => n.id == link.national);
    championships[championship_id] = championships[championship_id]
      ? championships[championship_id].concat(national)
      : national;
  }
  for (let i = 0; i < leaguelinks.length; i++) {
    const link = leaguelinks[i];
    var league_id = link.league;
    var club = clubs.filter((n) => n.id == link.club);
    leagues[league_id] = leagues[league_id]
      ? leagues[league_id].concat(club)
      : club;
  }
  return { championships: championships, leagues: leagues };
}

function playergamestats_faker(teamplayer) {
  var request_pgs =
    "INSERT INTO PlayerGameStats(team_player, game, three_pts, two_pts, free_pts, per_success, assists, rebounds, blocks, fouls) VALUES (?, @last_game_id, ?, ?, ?, ?, ?, ?, ?, ?);";
  var values_pgs = [
    teamplayer.id,
    randomInt(5),
    randomInt(7),
    randomInt(9),
    randomInt(100),
    randomInt(4),
    randomInt(8),
    randomInt(3),
    randomInt(10),
  ];
  var request_three =
    "UPDATE TeamPlayer SET three_pts = three_pts + ? WHERE id = ?;";
  var values_three = [values_pgs[1], teamplayer.id];
  var request_two = "UPDATE TeamPlayer SET two_pts = two_pts + ? WHERE id = ?;";
  var values_two = [values_pgs[2], teamplayer.id];
  var request_free =
    "UPDATE TeamPlayer SET free_pts = free_pts + ? WHERE id = ?;";
  var values_free = [values_pgs[3], teamplayer.id];
  var request_per =
    "UPDATE TeamPlayer SET per_success = ROUND((per_success + ?)/2) WHERE id = ?;";
  var values_per = [values_pgs[4], teamplayer.id];
  var request_assists =
    "UPDATE TeamPlayer SET assists = assists + ? WHERE id = ?;";
  var values_assists = [values_pgs[5], teamplayer.id];
  var request_rebounds =
    "UPDATE TeamPlayer SET rebounds = rebounds + ? WHERE id = ?;";
  var values_rebounds = [values_pgs[6], teamplayer.id];
  var request_blocks =
    "UPDATE TeamPlayer SET blocks = blocks + ? WHERE id = ?;";
  var values_blocks = [values_pgs[7], teamplayer.id];
  var request_fouls = "UPDATE TeamPlayer SET fouls = fouls + ? WHERE id = ?;";
  var values_fouls = [values_pgs[8], teamplayer.id];
  var request = request_pgs.concat(
    request_three,
    request_two,
    request_free,
    request_per,
    request_assists,
    request_rebounds,
    request_blocks,
    request_fouls
  );
  var values = values_pgs.concat(
    values_three,
    values_two,
    values_free,
    values_per,
    values_assists,
    values_rebounds,
    values_blocks,
    values_fouls
  );
  return { request: request, values: values };
}

function game_faker(
  nationals,
  clubs,
  championshiplinks,
  leaguelinks,
  teamplayers
) {
  var tournaments = parse_teams(
    nationals,
    clubs,
    championshiplinks,
    leaguelinks
  );
  var championships = tournaments.championships;
  var leagues = tournaments.leagues;
  if (binomial(0.5)) {
    var kind = "national";
    var tournament = multipleRandoms(Object.keys(championships), 1)[0];
    var teams = multipleRandoms(championships[tournament], 2).map(
      (t) => t.team
    );
  } else {
    var kind = "club";
    var tournament = multipleRandoms(Object.keys(leagues), 1)[0];
    var teams = multipleRandoms(leagues[tournament], 2).map((t) => t.team);
  }

  var request_pgs = "";
  var values_pgs = [];

  var players_t1 = multipleRandoms(
    teamplayers.filter((p) => p.team == teams[0]),
    5
  );
  var score_t1 = 0;

  players_t1.forEach((player) => {
    var playergamestats = playergamestats_faker(player);
    request_pgs = request_pgs.concat(playergamestats.request);
    values_pgs = values_pgs.concat(playergamestats.values);
    score_t1 +=
      playergamestats.values[1] * 3 +
      playergamestats.values[2] * 2 +
      playergamestats.values[3] * 1;
  });

  var players_t2 = multipleRandoms(
    teamplayers.filter((p) => p.team == teams[1]),
    5
  );
  var score_t2 = 0;

  players_t2.forEach((player) => {
    var playergamestats = playergamestats_faker(player);
    request_pgs = request_pgs.concat(playergamestats.request);
    values_pgs = values_pgs.concat(playergamestats.values);
    score_t2 +=
      playergamestats.values[1] * 3 +
      playergamestats.values[2] * 2 +
      playergamestats.values[3] * 1;
  });

  var request_game =
    "INSERT INTO Game(kind, kind_id, team_1, team_2, score_team_1, score_team_2) VALUES (?, ?, ?, ?, ?, ?);SET @last_game_id = LAST_INSERT_ID();";
  var values_game = [kind, tournament, teams[0], teams[1], score_t1, score_t2];
  return {
    request: request_game.concat(request_pgs),
    values: values_game.concat(values_pgs),
  };
}

function games_faker(
  nationals,
  clubs,
  championshiplinks,
  leaguelinks,
  teamplayers,
  number_games
) {
  var request = "";
  var values = [];
  for (let i = 0; i < number_games; i++) {
    var new_game = game_faker(
      nationals,
      clubs,
      championshiplinks,
      leaguelinks,
      teamplayers
    );
    request = request.concat(new_game.request);
    values = values.concat(new_game.values);
  }
  return { request: request, values: values };
}

module.exports = { game_faker, games_faker, parse_teams };
