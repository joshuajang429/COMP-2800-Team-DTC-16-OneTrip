// listen to auth changes

// auth.onAuthStateChanged(user => {
//     if(user) {
//         console.log("user has signed in");
//     } else {
//         console.log("nothing");
//     }
// })

firebase.auth().setPersistence(firebase.auth.Auth.Persistence.LOCAL);

// signup
// const signupForm = document.getElementById('#form-signup');
// signupForm.addEventListener('submit', (e) => {
//     e.preventDefault();


//     // get user info 
//     const email = signupForm['inputEmail'].value;
//     const password = signupForm['inputPassword'].value;

//     //signin for user
//     auth.createUserWithEmailAndPassword(email, password).then(cred => {
//         console.log(cred.user);
//         console.log("user has signed in");

//     });
 
// })

// $('#signin-btn').click(function() {
    
//     var email = $("#inputEmail").val();
//     var password = $("#inputPassword").val();
//     console.log("email: " + email + ", password: " + password);
//     // var result = firebase.auth().signInWithEmailAndPassword(email, password);
//     // result.catch(function(error) {
//     //     var errorCode = error.code;
//     //     var errorMessage = error.message;
//     //     console.log(errorCode);
//     //     console.log(errorMessage);
//     // })
// });

// const loginForm = document.getElementById('#form-signin');
// loginForm.addEventListener('submit', (e) => {
//     e.preventDefault();


//     // get user info 
//     const email = loginForm['inputEmail'].value;
//     const password = loginForm['inputPassword'].value;

//     //signin for user
//     auth.signInWithEmailAndPassword(email, password).then(cred => {
//         console.log(cred.user);
//         console.log("user has signed in");
//         window.location.href = "/";
// });
 
// })

