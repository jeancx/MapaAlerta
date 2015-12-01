<?php

namespace models;

use lib\Core;
use PDO;

class Bairro
{

    protected $core;

    function __construct()
    {
        $this->core = Core::getInstance();
        //$this->core->dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }

    // Get all users
    public function getAll()
    {
        $r = array();

        $sql = "SELECT b.id, b.nome, b.poligono, ST_AsGeoJSON(ST_FlipCoordinates(b.poligono)) AS poligono_json, (SELECT COUNT(*) FROM ocorrencias AS o where ST_Contains(b.poligono, o.ponto)) as ocorrencias FROM bairros as b";
        $stmt = $this->core->dbh->prepare($sql);

        if ($stmt->execute()) {
            $r = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } else {
            $r = 0;
        }
        return $r;
    }

    // Get all users
    public function geoJSon()
    {
        $r = array();

        $sql = "SELECT row_to_json(fc)
FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features
FROM (SELECT 'Feature' As type, ST_AsGeoJSON(ST_FlipCoordinates(b.poligono))::json As geometry,
row_to_json((SELECT l FROM (SELECT b.id, b.nome,(SELECT COUNT(*) FROM ocorrencias AS o where ST_Contains(b.poligono, o.ponto)) as ocorrencias) As l)) As properties
FROM bairros As b ) As f )  As fc";
        $stmt = $this->core->dbh->prepare($sql);

        if ($stmt->execute()) {
            $r = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } else {
            $r = 0;
        }
        return $r;
    }

    // Get all users
    public function kml()
    {
        $r = array();

        $sql = "SELECT CAST(as_kmldoc(ST_FlipCoordinates(poligono)) AS TEXT) FROM bairros";
        $stmt = $this->core->dbh->prepare($sql);
        if ($stmt->execute()) {
            $r = $stmt->fetch(PDO::FETCH_ASSOC);
        } else {
            $r = 0;
        }
        return $r['as_kmldoc'];
    }

    // Get bairro by the Id
    public function getById($id)
    {
        $r = array();

        $sql = "SELECT * FROM bairros WHERE id=:id";
        $stmt = $this->core->dbh->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);

        if ($stmt->execute()) {
            $r = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } else {
            $r = 0;
        }
        return $r;
    }

    // Insert a new bairro
    public function insert($data)
    {
        try {
            $sql = "INSERT INTO bairros (nome, poligono)
					VALUES (:nome, ST_GeomFromText(:poligono,4326))";
            $stmt = $this->core->dbh->prepare($sql);
            if ($stmt->execute($data)) {
                return $this->core->dbh->lastInsertId();;
            } else {
                return '0';
            }
        } catch (PDOException $e) {
            return $e->getMessage();
        }

    }

    // Update the data of an bairro
    public function updateBairro($data)
    {

    }

    // Delete bairro
    public function delete($id)
    {

        $r = array();

        $sql = "DELETE FROM bairros WHERE id=:id";
        $stmt = $this->core->dbh->prepare($sql);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);

        if ($stmt->execute()) {
            $r = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } else {
            $r = 0;
        }
        return $r;

    }

}