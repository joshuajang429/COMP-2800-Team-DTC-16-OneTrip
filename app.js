const express = require("express");
const app = express();
const mysql = require("mysql2");
const path = require("path");
const PORT = process.env.PORT || 3000;

const db = mysql.createPool({
    host: 'sql3.freemysqlhosting.net',
    user: 'sql3338383',
    database: 'sql3338383',
    password: 'tmVZZgLzY1'
}).promise();

app.use(express.urlencoded({extended: true}));
app.use(express.static(__dirname + '/public'));
app.use(express.static("public"));

// EJS Middleware
app.set("views", path.join(__dirname, "views/"))
app.set("view engine", "ejs");

//------Routing------//

app.get("/", (req, res) => {
    res.render("pages/index");
});

app.get("/signIn.ejs", (req, res) => {
    res.render("pages/signIn");
});

app.get("/signUp.ejs", (req, res) => {
    res.render("pages/signUp");
});

app.get("/map.ejs", (req, res) => {
    res.render("pages/map");
});

app.get("/marketlist.ejs", (req, res) => {
    res.render("pages/marketlist", {result: null});
});

app.get("/storepage.ejs", (req, res) => {
    let storeid = req.query.storeid;
    db.execute(`SELECT *, latest_wait_time(id) as wait_time FROM stores WHERE id = '${storeid}'`).
    then(([Data, Metadata]) => {
        console.log(Data);
        res.render("pages/storepage", {storeData: Data[0]});
    }).
    catch(error => console.log(error))
});



//------Posting-------//

app.post("/marketlist.ejs", (req, res) => {
    let input = req.body.storename;
    db.execute(`SELECT *, latest_wait_time(id) as wait_time FROM stores WHERE store_name LIKE '${input}'`).
    then(([Data, Metadata]) => {
        console.log(Data);
        res.render("pages/marketlist", {result: Data});
    }).
    catch(error => console.log(error))
})

app.listen(PORT, () => {
    console.log(`listening on ${PORT}`)
});