const express = require("express");
const mysql = require("mysql");
const app = express();
const bodyParser = require("body-parser");
const fs = require("fs");
const path = require("path");

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

app.get("/", (req, res) => {
  res.status(200).sendFile(__dirname + "/templates/homepage.html");
});

module.exports = app;
