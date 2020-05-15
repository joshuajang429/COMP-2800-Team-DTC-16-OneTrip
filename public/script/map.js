var map, service, infoWindow;

function initAutocomplete() {

    if ('geolocation' in navigator) {
        navigator.geolocation.getCurrentPosition((pos) => {
            map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: pos.coords.latitude, lng: pos.coords.longitude },
                zoom: 13,
                mapTypeId: 'roadmap'
            });

            marker = new google.maps.Marker({
                map: map,
                position: {
                    lat: pos.coords.latitude,
                    lng: pos.coords.longitude
                }
            });

            infoWindow = new google.maps.InfoWindow({
                content: document.getElementById('info-content')
            });
            service = new google.maps.places.PlacesService(map);

            // Create the search box and link it to the UI element.
            var input = document.getElementById('pac-input');
            var searchBox = new google.maps.places.SearchBox(input);
            // map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

            // Bias the SearchBox results towards current map's viewport.
            map.addListener('bounds_changed', function () {
                searchBox.setBounds(map.getBounds());
            });

            var markers = [];
            // Listen for the event fired when the user selects a prediction and retrieve
            // more details for that place.
            searchBox.addListener('places_changed', function () {
                var places = searchBox.getPlaces();

                if (places.length == 0) {
                    return;
                }

                // Clear out the old markers.
                markers.forEach(function (marker) {
                    marker.setMap(null);
                });
                markers = [];

                // For each place, get the icon, name and location.
                var bounds = new google.maps.LatLngBounds();
                places.forEach(function (place) {
                    if (!place.geometry) {
                        console.log("Returned place contains no geometry");
                        return;
                    }
                    var icon = {
                        url: place.icon,
                        size: new google.maps.Size(71, 71),
                        origin: new google.maps.Point(0, 0),
                        anchor: new google.maps.Point(17, 34),
                        scaledSize: new google.maps.Size(25, 25)
                    };

                    // Create a marker for each place.
                    markers.push(new google.maps.Marker({
                        map: map,
                        icon: icon,
                        placeId: place.place_id,
                        animation: google.maps.Animation.DROP,
                        title: place.name,
                        position: place.geometry.location
                    }));

                    if (place.geometry.viewport) {
                        // Only geocodes have viewport.
                        bounds.union(place.geometry.viewport);
                    } else {
                        bounds.extend(place.geometry.location);
                    }
                });

                for (let i = 0; i < markers.length; i++) {
                    // markers[i].placeResult = results[i];
                    google.maps.event.addListener(markers[i], 'click', async () => {
                        const api_url = `/waittime/${markers[i].placeId}`
                        const response = await fetch(api_url);
                        const json = await response.json();
                        // console.log(json);
                        const waittime = json.waittime;
                        // console.log(waittime)

                        service.getDetails({ placeId: markers[i].placeId }, (place, status) => {
                            if (status !== google.maps.places.PlacesServiceStatus.OK) {
                                return;
                            }
                            infoWindow.open(map, markers[i]);
                            buildIWContent(place, waittime);
                        });
                    });
                }

                // Load the place information into the HTML elements used by the info window.
                function buildIWContent(place, time) {
                    // document.getElementById('iw-icon').innerHTML = '<img class="hotelIcon" ' +
                    //     'src="' + place.icon + '"/>';
                    document.getElementById('iw-url').innerHTML = '<b><a href="' + place.url +
                        '">' + place.name + '</a></b>';
                    document.getElementById('iw-address').textContent = place.vicinity;
                    document.getElementById('iw-waiting').textContent = time + ' minutes';

                    if (place.formatted_phone_number) {
                        document.getElementById('iw-phone-row').style.display = '';
                        document.getElementById('iw-phone').textContent =
                            place.formatted_phone_number;
                    } else {
                        document.getElementById('iw-phone-row').style.display = 'none';
                    }

                    // Assign a five-star rating to the hotel, using a black star ('&#10029;')
                    // to indicate the rating the hotel has earned, and a white star ('&#10025;')
                    // for the rating points not achieved.
                    if (place.rating) {
                        var ratingHtml = '';
                        for (var i = 0; i < 5; i++) {
                            if (place.rating < (i + 0.5)) {
                                ratingHtml += '&#10025;';
                            } else {
                                ratingHtml += '&#10029;';
                            }
                            document.getElementById('iw-rating-row').style.display = '';
                            document.getElementById('iw-rating').innerHTML = ratingHtml;
                        }
                    } else {
                        document.getElementById('iw-rating-row').style.display = 'none';
                    }
                }
                map.fitBounds(bounds);
            });

        });
    }
}
