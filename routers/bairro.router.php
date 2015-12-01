<?php

use \models\Bairro;

$app->get('/api/bairros', function () use ($app) {
    $model = new Bairro();
    $list = $model->getAll();
    $app->contentType('application/json');
    echo json_encode($list);
});

$app->get('/api/bairros/geojson', function () use ($app) {
    $model = new Bairro();
    $list = $model->geoJSon();
    $app->contentType('application/json');
    echo $list[0]['row_to_json'];
});

$app->get('/api/bairros.kml', function () use ($app) {
    $model = new Bairro();
    $kml = $model->kml();
    $app->contentType('application/json');
    echo $kml;
});

$app->post('/api/bairros/add', function () use ($app) {

    $model = new Bairro();

    $data = $app->request()->post();

    $data['poligono'] = str_replace(",", " ", $data['poligono']);
    $data['poligono'] = str_replace("  ", " ", $data['poligono']);
    $data['poligono'] = explode(")(", $data['poligono']);

    $pol = "POLYGON((";
    foreach ($data['poligono'] as $p) {
        $p = str_replace("(", " ", $p);
        $p = str_replace(")", " ", $p);
        $pol .= "$p,";
    }
    $data['poligono'][0] = str_replace("(", " ", $data['poligono'][0]);
    $pol .= $data['poligono'][0];
    $pol .= "))";
    $data['poligono'] = $pol;

    $myfile = fopen("debug.txt", "w") or die("Unable to open file!");
    fwrite($myfile, print_r($data, true));
    fclose($myfile);

    $app->response->body($model->insert($data));

});