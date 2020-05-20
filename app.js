const express = require("express");
const app = express();
const mysql = require("mysql2");
const path = require("path");
const PORT = process.env.PORT || 3000;

const firebase = require("firebase/app");
firebase.initializeApp({
    apiKey: "AIzaSyCmidJ7Dopj865jlAM7w4Oh6mSvCIGdAJg",
    authDomain: "onetrip-5349f.firebaseapp.com",
    databaseURL: "https://onetrip-5349f.firebaseio.com",
    projectId: "onetrip-5349f",
    storageBucket: "onetrip-5349f.appspot.com",
    messagingSenderId: "752676431359",
    appId: "1:752676431359:web:1be0e9787cb5b10f9ef3ca",
    measurementId: "G-9EVM86CMWZ"
});
require("firebase/auth");
// require("firebase/firestore");

const db = mysql.createPool({
    host: 'sql3.freemysqlhosting.net',
    user: 'sql3340725',
    database: 'sql3340725',
    password: 'rLfIG2Tz6u'
}).promise();

app.use(express.urlencoded({ extended: true }));
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
    res.render("pages/marketlist", { result: null });
});

app.get("/storepage.ejs", (req, res) => {
    let storeid = req.query.storeid;
    db.execute(`CALL get_store_info_with_id_senior(${storeid})`).
    then(([Data, Metadata]) => {
        console.log(Data[0]);
        res.render("pages/storepage", { storeData: Data[0][0] });
    }).
    catch(error => console.log(error))
});

//-----Getting waittime from db-------//

app.get("/waittime/:postalCode", async(req, res) => {
    const placeId = req.params.postalCode.split(',');
    const postalCode = placeId[0];

    db.execute(`SELECT latest_wait_time_post_code('${postalCode}') as wait_time, get_store_id_with_post_code('${postalCode}') as store_id`).
    then(([Data, Metadata]) => {
        let waitTime = Data[0]['wait_time'];
        let storeID = Data[0]['store_id']

        if (waitTime != null && storeID != null) {
            const data = {
                waittime: waitTime,
                storeid: storeID
            }
            res.json(data);
        } else {
            const data = {
                waittime: "N/A",
                storeid: 0
            }
            res.json(data);
        }
    }).
    catch(error => console.log(error))
});

app.get("/update.ejs", (req, res) => {
    let storeid = req.query.storeid;
    db.execute(`CALL get_store_info_with_id(${storeid})`).
    then(([Data, Metadata]) => {
        console.log(Data[0]);
        res.render("pages/update", { storeData: Data[0][0] });
    }).
    catch(error => console.log(error))
});

//------Posting-------//

app.post("/marketlist.ejs", (req, res) => {
    let input = req.body.storename;
    db.execute(`CALL get_store_info('${input}')`).
    then(([Data, Metadata]) => {
        console.log(Data[0]);
        res.render("pages/marketlist", { result: Data[0] });
    }).
    catch(error => console.log(error))
})

app.post("/storepage.ejs", (req, res) => {
    let storeid = req.body.storeid;
    console.log(storeid);
    res.redirect(`/update.ejs?storeid=${storeid}`);
})

app.post("/update.ejs", (req, res) => {
    let data = req.body;
    console.log(`ID: ${data.store}, Time: ${data.wait_time}`);
    db.execute(`CALL update_time_test(${data.store}, ${data.wait_time})`).
    then(([Data, Metadata]) => {
        res.redirect(`/storepage.ejs?storeid=${data.store}`)
    }).
    catch(error => console.log(error))
})

app.listen(PORT, () => {
    console.log(`listening on ${PORT}`)
});