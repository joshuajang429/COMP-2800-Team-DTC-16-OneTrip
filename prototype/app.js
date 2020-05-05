const express = require("express");

let app = express();
    app.use(express.urlencoded({extended: true}));
    app.use(express.static("public"));
    app.set("view engine", "ejs");

const port = 3000;


// routes from here
app.get("/", (req, res)=> res.render("pages/index"));

app.listen(port);