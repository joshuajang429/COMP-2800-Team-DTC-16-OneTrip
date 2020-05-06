const express = require("express");

let app = express();
    app.use(express.urlencoded({extended: true}));
    app.use(express.static("public"));
    app.set("view engine", "ejs");
    

const port = 3000;


// route starts from here
app.get("/", (req, res) => res.render("pages/index"));

app.get("/signin", (req, res) => res.render("pages/signin"));

app.get("/findlocation", (req, res) => res.render("pages/findlocation"));

app.get("/map", (req, res) => res.render("pages/map"));

app.get("/waitingtime", (req, res) => res.render("pages/waitingtime"));

app.get("/update", (req, res) => res.render("pages/update"));

app.get("/marketinfo", (req, res) => res.render("pages/marketinfo"));



app.listen(port);