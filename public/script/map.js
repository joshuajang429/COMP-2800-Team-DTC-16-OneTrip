let map = document.createElement('iframe');
let mapHolder = document.getElementById('map');
let key = "AIzaSyBMN5A6BZM022m3zZ35SsgwJWlTW3SGL4g"

if ('geolocation' in navigator) {
    navigator.geolocation.getCurrentPosition(async position => {

        let current_lat = position.coords.latitude;
        let current_lng = position.coords.longitude;

        map.src = `https://www.google.com/maps/embed/v1/search?key=${key}
        &q=stores+near+me&center=${current_lat},${current_lng}&zoom=15`
        mapHolder.appendChild(map);
    });
}

let search = document.getElementById('search');

document.querySelector('form.pure-form').addEventListener('submit', function (e) {
    e.preventDefault();

    if ('geolocation' in navigator) {
        navigator.geolocation.getCurrentPosition(async position => {
    
            let current_lat = position.coords.latitude;
            let current_lng = position.coords.longitude;
    
            map.src = `https://www.google.com/maps/embed/v1/search?key=${key}
            &q=${search.value}+near+me&center=${current_lat},${current_lng}&zoom=14`
            mapHolder.appendChild(map);
        });
    }

    console.log(search.value);
})

// function initMap() {
//     // The Current Location

//     if ('geolocation' in navigator) {
//         navigator.geolocation.getCurrentPosition(async position => {
//             lng = position.coords.longitude;

//             // The map, centered at Current location
//             var map = new google.maps.Map(document.getElementById('map'), {
//                 zoom: 15, 
//                 center: {lat: position.coords.latitude, lng: position.coords.longitude}
//             });
//             // The marker, positioned at Uluru
//             var marker = new google.maps.Marker({
//                 position: {
//                     lat: position.coords.latitude, 
//                     lng: position.coords.longitude
//                 }, 
//                 map: map
//             });
//         })
//     }
// }