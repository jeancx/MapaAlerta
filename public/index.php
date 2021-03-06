<?php

require '../vendor/autoload.php';
require '../config.php';

use lib\Config;

date_default_timezone_set('America/Sao_Paulo');

session_cache_limiter(false);
session_start();

// Setup custom Twig view
$twigView = new \Slim\Views\Twig();

$app = new \Slim\Slim(array(
    'debug' => true,
    'view' => $twigView,
    'templates.path' => '../templates/',
));

// Automatically load router files
$routers = glob('../routers/*.router.php');
foreach ($routers as $router) {
    require $router;
}

$app->url = Config::read('path');

$app->hook('slim.before.dispatch', function() use ($app) {

    $url = Config::read('path');
    $app->view()->setData('url', $url);
    $app->view()->setData('session', $_SESSION);

});

$app->run();
