<?php

use \models\Ocorrencia;

$app->get('/api/ocorrencias', function () use ($app) {
    $model = new Ocorrencia();
    $list = $model->getAll();
    $app->contentType('application/json');
    echo json_encode($list);
});

$app->get('/api/ocorrencias/geojson', function () use ($app) {
    $model = new Ocorrencia();
    $list = $model->geoJSon();
    $app->contentType('application/json');
    echo $list[0]['row_to_json'];
});

$app->get('/api/ocorrencias.kml', function () use ($app) {
    $model = new Ocorrencia();
    $kml = $model->kml();
    $app->contentType('application/json');
    echo $kml;
});

$app->post('/api/ocorrencias/add', function () use ($app) {

    $model = new Ocorrencia();
    $data = $app->request()->post();

    $myfile = fopen("debug.txt", "w") or die("Unable to open file!");
    fwrite($myfile, print_r($data, true));
    fclose($myfile);

    $app->response->body($model->insert($data));

});