firebase.auth().setPersistence(firebase.auth.Auth.Persistence.LOCAL);

$('#signup-btn').click(function() {
    var email = $("#inputEmail").val();
    var password = $("#inputPassword").val();
    var confirmPassword = $("#inputConfirmPassword").val();
    console.log("email: " + email + ", password: " + password);

    
    if(password == confirmPassword) {
        var result = firebase.auth().createUserWithEmailAndPassword(email, password);
        result.catch(function(error) {
            var errorCode = error.code;
            var errorMessage = error.message;
            console.log(errorCode);
            console.log(errorMessage);
        })
    }
    
    else{
        window.alert("Passwords do not match");
    }
});

$('#signin-btn').click(function() {
    var email = $("#inputEmail").val();
    var password = $("#inputPassword").val();
    var result = firebase.auth().signInWithEmailAndPassword(email, password);
    result.catch(function(error) {
        var errorCode = error.code;
        var errorMessage = error.message;
        console.log(errorCode);
        console.log(errorMessage);
    })
});

$("#logout").click(function(){
    firebase.auth().signOut();
    window.location.replace("/");
});