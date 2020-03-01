var express = require("express");
var router = express.Router();

var app = express();

var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: false }));


var firebase = require("firebase");
require("firebase/firestore");
const config = {
  apiKey: "AIzaSyBSqteCFUjOut64LdWtcQIlV9WqpCdTo9M",
  authDomain: "profhack-3fab3.firebaseapp.com",
  databaseURL: "https://profhack-3fab3.firebaseio.com",
  projectId: "profhack-3fab3",
  storageBucket: "profhack-3fab3.appspot.com",
  messagingSenderId: "719556600838",
  appId: "1:719556600838:web:b930844b910fa09e43cf87",
  measurementId: "G-WEYTGW9ECR"
};

firebase  .initializeApp(config);

var database = firebase.database();


router.get("/details", function(req, res, next) {
});

router.get("/leaderboard", function(req, res, next) {
  var leader =[];
  database.ref('/leaderboard').orderByValue().on("value", function(snapshot) {
    snapshot.forEach(function(data) {
      leader.push(`${data.key} - ${data.val()}`);
    });
  })
  var toreturn = "";
  for (var i = leader.length-1; i > 0; i--) {
    toreturn += leader[i];
    toreturn += ",";
  }
  toreturn += leader[0];
  res.send(toreturn);
});

router.get("/storage", function(req, res, next) {
  database.ref('user1').once('value').then(function(snapshot) {
    res.send(`${snapshot.val().storaget},${snapshot.val().storager}`);
  })
});

router.get("/stats", function(req, res, next) {
  database.ref('user1').once('value').then(function(snapshot) {
    var trash = snapshot.val().trash;
    var recycle = snapshot.val().recycle;
    res.send(`${trash.toString()},${recycle.toString()}`);
  })
});

router.get("/history", function(req, res, next) {
  var toreturn = "";
  var history = [];
  database.ref('user1/history').once('value').then(function(snapshot) {
    // snapshot.forEach(function(data) {
    //   history.push(`${snapshot}`)
    // })
    res.send(toreturn);
  })
  for (var i = 0; i < history.length-1; i++) {
    toreturn += history[i];
    toreturn += ","
  }
  toreturn += history[history.length-1];
});

router.get("/history/image", function(req, res, next) {

});

module.exports = router;
