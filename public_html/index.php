<?php
require '../vendor/autoload.php';


$app = new \Slim\Slim([
  "templates.path" => "../template",
  "mode" => "production"

]);
$db = new PDO('sqlite:../database.db');
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


$app->notFound(function () use ($app) {
  echo "404";
});

$app->get('/', function () use ($app, $db) {
  echo "Yo";
});

$app->run();
