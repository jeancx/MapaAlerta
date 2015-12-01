$(function () {

    var map;
    var geocoder;
    var marker;
    var ocorrencias;
    var bairros;
    creator = null;

    google.maps.event.addDomListener(window, 'load', initialize);

    function initialize() {
        /* SJB 27.2740622,-48.8773824 48.8503707!2d-27.2758303 */
        var latlng = new google.maps.LatLng(-26.900946, -48.684542);
        geocoder = new google.maps.Geocoder();
        var mapOptions = {
            center: latlng,
            scrollWheel: false,
            zoom: 13
        };

        map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

        loadGeoJSon();

    };

    function loadGeoJSon(){

        $.getJSON("api/ocorrencias/geojson", function(data) {
            ocorrencias = map.data.addGeoJson(data);
        });

        $.getJSON("api/bairros/geojson", function(data) {
            bairros = map.data.addGeoJson(data);
        });

        map.data.setStyle({
            icon: 'img/pirates.png',
            fillColor: 'red'
        });

        map.data.setStyle(function(feature) {

            if(feature.getProperty('ocorrencias')) {

                var opacity = 0;
                var color = 'red';

                var ocorrencias = Number(feature.getProperty('ocorrencias'));

                console.log(feature.getProperty('nome') + ":" + ocorrencias);

                if (ocorrencias == 0) {
                    opacity = 0;
                    color = 'green';
                }
                if (ocorrencias > 0 && ocorrencias <= 5) {
                    opacity = 0.25;
                    color = 'yellow';
                }
                if (ocorrencias > 5 && ocorrencias <= 10) {
                    opacity = 0.5;
                    color = 'red';
                }
                if (ocorrencias > 10 && ocorrencias <= 20) {
                    opacity = 0.75;
                    color = 'red';
                }
                if (ocorrencias > 20) {
                    opacity = 1;
                    color = 'red';
                }

                return {
                    fillOpacity: opacity,
                    fillColor: color,
                    strokeWeight: 1
                };
            }else{
                return {
                    icon: 'img/pirates.png',
                    fillOpacity: 0.1,
                    fillColor: 'green',
                    strokeWeight: 1
                };
            }
        });

    }


    function initializeMarker() {
        // Pega coordenadas com base no CLick do map
        google.maps.event.addListener(map, "click", function (event) {
            var lat = event.latLng.lat().toFixed(6);
            var lng = event.latLng.lng().toFixed(6);
            createMarker(lat, lng);
            getCoords(lat, lng);
        });

    }

    // Cria marcador
    function createMarker(lat, lng) {
        if (marker) {
            marker.setMap(null);
            marker = "";
        }
        var titulo = document.getElementById('nomeOcorrencia').value;
        var myLatlng = new google.maps.LatLng(Number(lat),Number(lng));
        marker = new google.maps.Marker({
            map: map,
            draggable: true,
            animation: google.maps.Animation.DROP,
            position: myLatlng,
            title: titulo
        });
        google.maps.event.addListener(marker, 'dragend', function () {
            marker.position = marker.getPosition();
            var lat = marker.position.lat().toFixed(6);
            var lng = marker.position.lng().toFixed(6);
            getCoords(lat, lng);
        });
    }

    // Atualiza Coordenadas dos Inputs
    function getCoords(lat, lng) {
        document.getElementById('latOcorrencia').value = lat;
        document.getElementById('longOcorrencia').value = lng;
    }

    // Centraliza e Marca no ma pesquisando o endereÃ§o do cliente
    function codeAddress(address) {
        geocoder.geocode({'address': address}, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);

                var lat = results[0].geometry.location.lat();
                var lng = results[0].geometry.location.lng();
                getCoords(lat, lng);
            } else {
                alert("Geocode nÃ£o obteve sucesso pela seguinte razÃ£o: " + status);
            }
        });
    }

    // Seta centro baseado no endereco
    function setAdress(address) {
        geocoder.geocode({'address': address}, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                var lat = results[0].geometry.location.lat();
                var lng = results[0].geometry.location.lng();
                getCoords(lat, lng);
            }
        });
    }

    function centerMap(lat, lng) {
        if (marker) {
            marker.setMap(null);
            marker = "";
        }

        marker = new google.maps.Marker({
            position: new google.maps.LatLng(lat, lng),
            draggable: true,
            map: map
        });

        map.setCenter(lat, lng);

    }

    $("#busca").keyup(function (e) {
        if (e.keyCode == 13) {
            var endereco = e.target.value;
            console.log(endereco);
            codeAddress(endereco);
        }
    });


    $("#addOcorrencia").click(function () {

        if (null != creator) {
            creator.destroy();
            creator = null;
        }

        map.data.forEach(function (feature) {
            map.data.remove(feature);
        });

        map = initializeMarker();

        $.getJSON("api/bairros", function(result) {
            var options = $("#bairroOcorrencia");
            $.each(result, function(item) {
                options.append($("<option />").val(result[item].id).text(result[item].id+' - '+result[item].nome));
            });
        });

    });

    $("#addBairro").click(function () {
        if (null != marker) {
            consolle.log("remove marker");
            marker.setMap(null);
            marker = "";
        }
        if (null != creator) {
            creator.destroy();
            creator = null;
        }
        creator = new PolygonCreator(map);
    });


    $('#resetPath').click(function () {
        $('#bairroPolygon').empty();
        creator.destroy();
        creator = null;
        creator = new PolygonCreator(map);
    });

    //show paths
    $('#showPath').click(function () {
        $('#bairroPolygon').empty();
        if (null == creator.showData()) {
            $('#bairroPolygon').append('Por favor crie um poligono primeiro.');
        } else {
            $('#bairroPolygon').append(creator.showData());
        }
    });

    $('#salvaOcorrencia').click(function (e) {
        var bairro = $('#bairroOcorrencia').val();
        var nome = $('#nomeOcorrencia').val();
        var pontoLat = $('#latOcorrencia').val();
        var pontoLng = $('#longOcorrencia').val();
        var descricao = tinyMCE.get('descricaoOcorrencia').getContent();
        e.preventDefault();
        if (!pontoLat || !pontoLng) {
            var alert = '<br><div class = "alert alert-danger">Por escolha um ponto primeiro!</div><br>';
            $('#alertaOcorrencia').html(alert);
        } else {
            var ponto = 'POINT('+pontoLat+' '+pontoLng+')';
            $.post("api/ocorrencias/add", {bairro: bairro, nome: nome, ponto: ponto, descricao: descricao})
                .done(function (data) {
                    console.log("ocorrencia inserida");
                    var alert = '<br><div class = "alert alert-success">Ocorrencia inserido!</div><br>'
                    $('#alertaOcorrencia').html(alert);
                });
        }
    });

    $('#salvaBairro').click(function (e) {
        e.preventDefault();
        $('#bairroPolygon').empty();
        $('#bairroPolygon').append(creator.showData());
        if (null == creator.showData()) {
            $('#bairroPolygon').append('Por favor crie um poligono primeiro.');
        } else {
            var nome = $('#nomeBairro').val();
            var poligono = creator.showData();

            $.post("api/bairros/add", {nome: nome, poligono: poligono})
                .done(function (data) {
                    console.log("bairro inserido");
                    var alert = '<br><br><div class = "alert alert-success">Bairro inserido!</div>'
                    $('#bairroPolygon').append(alert);
                });
        }
    });
    $("#bairrosTable").data( "height", $("#left").height());
    $("#ocorrenciasTable").data( "height", $("#left").height());




});
