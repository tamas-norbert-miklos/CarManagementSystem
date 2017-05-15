$(document).ready(function() {
    $.ajax({
        url: "http://localhost:8080/car/numberOfCars"
    }).then(function(data) {
        $('.dbsize').append(data.carsInDb);
    });
});