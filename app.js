const express = require("express");
const mysql = require("mysql");
const app = express();
const bodyParser = require("body-parser");
const fs = require("fs");
const path = require("path");
const { team_faker, teams_faker } = require("./fakers/team_faker");
const { players_faker } = require("./fakers/player_faker");
const { game_faker, games_faker, parse_teams } = require("./fakers/game_faker");

app.use(
  bodyParser.json({
    extended: true,
  })
);

//Paramétrage de la connexion à la BDD
const bdd = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "bonjoure",
  database: "basketball",
  multipleStatements: true,
});

//Connexion à la BDD
bdd.connect(function (err) {
  if (err) throw err;
  console.log("Connecté !");
});

app.post("/team_faker", (req, res) => {
  var number_teams = req.body.number_teams;
  if (number_teams == 0) {
    res.status(400).send("You must create at least one team !");
  } else {
    bdd.query(
      "SELECT * FROM City; SELECT * FROM Country; SELECT * FROM Sponsor; SELECT * FROM Championship; SELECT * FROM League;",
      (err, result) => {
        if (err) throw err;
        var raw_data = JSON.parse(JSON.stringify(result));
        var cities = raw_data[0];
        var countries = raw_data[1];
        var sponsors = raw_data[2];
        var championships = raw_data[3];
        var leagues = raw_data[4];
        var new_teams = teams_faker(
          cities,
          countries,
          sponsors,
          championships,
          leagues,
          number_teams
        );

        bdd.query(new_teams.request, new_teams.values, (err, result) => {
          if (err) throw err;
          res.status(200).send("Teams created !");
        });
      }
    );
  }
});

app.post("/player_faker", (req, res) => {
  var number_players = req.body.number_players;
  if (number_players == 0) {
    res.status(400).send("You must create at least one team !");
  } else {
    bdd.query("SELECT * FROM Team; SELECT * FROM Country;", (err, result) => {
      if (err) throw err;
      var raw_data = JSON.parse(JSON.stringify(result));
      var teams = raw_data[0];
      var countries = raw_data[1];

      if (teams.length == 0) {
        res.status(400).send("You must first create teams !");
      } else {
        var new_players = players_faker(teams, countries, number_players);

        bdd.query(new_players.request, new_players.values, (err, result) => {
          if (err) throw err;
          res.status(200).send("Players created !");
        });
      }
    });
  }
});

app.post("/game_faker", (req, res) => {
  var number_games = req.body.number_games;
  if (number_games == 0) {
    res.status(400).send("You must create at least one team !");
  } else {
    bdd.query(
      "SELECT * FROM National; SELECT * FROM Club; SELECT * FROM ChampionshipLink; SELECT * FROM LeagueLink; SELECT * FROM TeamPlayer;",
      (err, result) => {
        if (err) throw err;
        var raw_data = JSON.parse(JSON.stringify(result));
        var nationals = raw_data[0];
        var clubs = raw_data[1];
        var championshiplinks = raw_data[2];
        var leaguelinks = raw_data[3];
        var teamplayers = raw_data[4];
        var new_games = games_faker(
          nationals,
          clubs,
          championshiplinks,
          leaguelinks,
          teamplayers,
          number_games
        );
        if (new_games == false) {
          res
            .status(400)
            .send(
              "A league or a championship has not enough teams. Please create more teams."
            );
        } else {
          bdd.query(new_games.request, new_games.values, (err, result) => {
            if (err) throw err;
            res.status(200).send("Games played !");
          });
        }
      }
    );
  }
});

app.get("/tournaments/*", (req, res) => {
  bdd.query(
    "SELECT Team.id AS id, Team.name AS name, Country.name AS country FROM National INNER JOIN Team ON National.team = Team.id INNER JOIN Country ON National.country = Country.id; SELECT Team.id AS id, Team.name AS name, City.name AS city FROM Club INNER JOIN Team ON Club.team = Team.id INNER JOIN City ON Club.city = City.id; SELECT * FROM ChampionshipLink; SELECT * FROM LeagueLink; SELECT * FROM Championship; SELECT * FROM League;",
    (err, result) => {
      if (err) throw err;
      var raw_data = JSON.parse(JSON.stringify(result));
      var nationals = raw_data[0];
      var clubs = raw_data[1];
      var championshiplinks = raw_data[2];
      var leaguelinks = raw_data[3];
      var championships = raw_data[4];
      var leagues = raw_data[5];
      var tournaments = parse_teams(
        nationals,
        clubs,
        championshiplinks,
        leaguelinks
      );
      if (req.url == "/tournaments/championships") {
        res.status(200).send({
          nationals: tournaments.championships,
          championships: championships,
        });
      } else if (req.url == "/tournaments/leagues") {
        res.status(200).send({ clubs: tournaments.leagues, leagues: leagues });
      } else {
        res.status(400).send("No kind of tournament called so.");
      }
    }
  );
});

app.get("/get_team_info/*", (req, res) => {
  var team_id = req.url.split("/").slice(-1)[0];
  bdd.query("SELECT * FROM Team WHERE id = ?;", [team_id], (err, result) => {
    if (err) throw err;
    var raw_data = JSON.parse(JSON.stringify(result));
    if (result[0].kind == "club") {
      bdd.query(
        "SELECT TeamPlayer.id AS number, Player.id, Player.name, Country.citizenship AS citizenship, birth FROM Player INNER JOIN TeamPlayer ON Player.id = TeamPlayer.player INNER JOIN Country ON Player.citizenship = Country.id WHERE Team = ?; SELECT Team.id AS id, Team.name AS name, City.name AS location, Team.kind FROM Club INNER JOIN Team ON Club.team = Team.id INNER JOIN City ON Club.city = City.id WHERE Team.id = ?; SELECT Sponsor.name, amount, City.name AS city FROM Sponsor INNER JOIN SponsorLink ON Sponsor.id = SponsorLink.sponsor INNER JOIN City ON City.id = Sponsor.city WHERE SponsorLink.team = ?;SELECT League.name FROM League INNER JOIN LeagueLink ON LeagueLink.league = League.id WHERE LeagueLink.club = ?;",
        [team_id, team_id, team_id, team_id],
        (err, result) => {
          if (err) throw err;
          var raw_data = JSON.parse(JSON.stringify(result));
          var teamplayers = raw_data[0];
          var team = raw_data[1][0];
          var sponsors = raw_data[2];
          var leagues = raw_data[3];
          res
            .status(200)
            .send({ teamplayers, team, sponsors, tournaments: leagues });
        }
      );
    } else if (result[0].kind == "national") {
      bdd.query(
        "SELECT TeamPlayer.id AS number, Player.id, Player.name, Country.citizenship AS citizenship, birth FROM Player INNER JOIN TeamPlayer ON Player.id = TeamPlayer.player INNER JOIN Country ON Player.citizenship = Country.id WHERE Team = ?; SELECT Team.id AS id, Team.name AS name, Country.name AS location, Team.kind FROM National INNER JOIN Team ON National.team = Team.id INNER JOIN Country ON National.country = Country.id WHERE Team.id = ?; SELECT Sponsor.name, amount, City.name AS city FROM Sponsor INNER JOIN SponsorLink ON Sponsor.id = SponsorLink.sponsor INNER JOIN City ON City.id = Sponsor.city WHERE SponsorLink.team = ?;SELECT Championship.name FROM Championship INNER JOIN ChampionshipLink ON ChampionshipLink.Championship = Championship.id WHERE ChampionshipLink.national = ?;",
        [team_id, team_id, team_id, team_id],
        (err, result) => {
          if (err) throw err;
          var raw_data = JSON.parse(JSON.stringify(result));
          var teamplayers = raw_data[0];
          var team = raw_data[1][0];
          var sponsors = raw_data[2];
          var championships = raw_data[3];
          res
            .status(200)
            .send({ teamplayers, team, sponsors, tournaments: championships });
        }
      );
    }
  });
});

app.get("/get_player_info/*", (req, res) => {
  var player_id = req.url.split("/").slice(-1)[0];
  bdd.query(
    "SELECT Player.name, birth, height, Country.citizenship FROM Player INNER JOIN Country ON Player.citizenship = Country.id WHERE Player.id = ?;SELECT * FROM TeamPlayer INNER JOIN Team ON TeamPlayer.team = Team.id WHERE player = ?;",
    [player_id, player_id],
    (err, result) => {
      if (err) throw err;
      var raw_data = JSON.parse(JSON.stringify(result));
      var player = raw_data[0][0];
      var teamplayers = raw_data[1];
      var teams = [];
      teamplayers.forEach((row) => {
        teams.push(row.id);
      });
      var teams_SQL = "(" + teams.toString() + ")";
      bdd.query(
        "SELECT three_pts, two_pts, free_pts, per_success, assists, rebounds, blocks, fouls, Game.kind, Team1.name AS team_1, Team2.name AS team_2, Game.score_team_1, Game.score_team_2 FROM PlayerGameStats INNER JOIN Game ON PlayerGameStats.game = Game.id INNER JOIN Team AS Team1 ON Team1.id = Game.team_1 INNER JOIN Team AS Team2 ON Team2.id = Game.team_2 WHERE team_player IN " +
          teams_SQL, // we ignore SQL insertions here because we need raw text, and data comes from DB
        (err, result) => {
          if (err) throw err;
          var player_games = JSON.parse(JSON.stringify(result));
          res.status(200).send({ player, teamplayers, player_games });
        }
      );
    }
  );
});

app.get("/team/*", (req, res) => {
  res.status(200).sendFile(__dirname + "/templates/team.html");
});

app.get("/player/*", (req, res) => {
  res.status(200).sendFile(__dirname + "/templates/player.html");
});

app.get("/", (req, res) => {
  res.status(200).sendFile(__dirname + "/templates/homepage.html");
});

app.get("/*", (req, res) => {
  res.status(200).sendFile(__dirname + req.url);
});

module.exports = app;
