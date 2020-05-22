firebase.auth().setPersistence(firebase.auth.Auth.Persistence.LOCAL);

// Uses firebase to sign up the user
// Grabs email, password from the user
// Code snippet found on youtube.com
// Author: Coding Cafe
// https://www.youtube.com/watch?v=D6Jw4zFP0SQ&list=PLxefhmF0pcPmK1c4qQS9wr9Zqdj0x_uLo&index=9&t=0s

$('#signup-btn').click(function () {
    var email = $("#inputEmail").val();
    var password = $("#inputPassword").val();
    var confirmPassword = $("#inputConfirmPassword").val();
    console.log("email: " + email + ", password: " + password);


    if (password == confirmPassword) {
        var result = firebase.auth().createUserWithEmailAndPassword(email, password);
        result.catch(function (error) {
            var errorCode = error.code;
            var errorMessage = error.message;
            console.log(errorCode);
            console.log(errorMessage);
        })
    }

    else {
        window.alert("Passwords do not match");
    }
});

// Uses firebase to sign up the user
// Grabs email, password from the user
// Code snippet found on youtube.com
// Author: Coding Cafe
// https://www.youtube.com/watch?v=D6Jw4zFP0SQ&list=PLxefhmF0pcPmK1c4qQS9wr9Zqdj0x_uLo&index=9&t=0s

$('#signin-btn').click(function () {
    var email = $("#inputEmail").val();
    var password = $("#inputPassword").val();
    var result = firebase.auth().signInWithEmailAndPassword(email, password);
    result.catch(function (error) {
        var errorCode = error.code;
        var errorMessage = error.message;
        console.log(errorCode);
        console.log(errorMessage);
    })
});

// Uses firebase to log out the user
// Code snippet found on youtube.com
// Author: Coding Cafe
// https://www.youtube.com/watch?v=mBh3HZaC_qo&list=PLxefhmF0pcPmK1c4qQS9wr9Zqdj0x_uLo&index=7

$("#logout").click(function () {
    firebase.auth().signOut();
    window.location.replace("/");
});