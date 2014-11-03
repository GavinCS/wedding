$('document').ready(function(){
    var coords  = $('#map').data('marker');
    var image   = $('#map').data('marker-image');

    if ($('#map').length) {
        window.handler = Gmaps.build('Google');
        handler.buildMap({
            provider: {
                zoom: 12
            },
            internal: {
                id: 'map'
            }
        }, function(){
            if(navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(displayOnMap);
            }

            if (coords != 'undefined') {
                addAccMarker(coords, image);
            }

        });
    }
});

function displayOnMap(position){
    handler.addMarker({
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        infowindow: "You are here"
    });
    
}

function addAccMarker(coords, image)
{

    var accMarker = handler.addMarker({
        lat: parseFloat(coords[0].lat),
        lng: parseFloat(coords[0].lng),
        infowindow: "<img src='"+ image +"'> I'm Foo"
    });
    handler.map.centerOn(accMarker);
}



//    $('//showMarker').on('click', function(e){
//        console.log('hello');
//        e.preventDefault();

//        var newMarker = handler.addMarker({
//          //  lat: parseFloat($('//accommodation_latitude').val()),  //-33.8997364
//          //  lng: parseFloat($('//accommodation_longitude').val()) // 18.7173125
//        });
//
//        handler.map.centerOn(newMarker);
//  });
//
