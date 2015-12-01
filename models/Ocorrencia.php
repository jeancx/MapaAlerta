<?php

namespace models;

use lib\Core;
use PDO;

class Ocorrencia
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

        $sql = "SELECT o.id, o.nome, o.bairro_id, b.nome AS bairro, o.ponto, ST_AsGeoJSON(o.ponto) AS ponto_jSon, o.descricao FROM ocorrencias AS o INNER JOIN bairros AS b ON o.bairro_id = b.id;";
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
FROM (SELECT 'Feature' As type, ST_AsGeoJSON(ST_FlipCoordinates(oc.ponto))::json As geometry, row_to_json((SELECT l FROM (SELECT oc.id, oc.nome, 0 AS ocorrencias) As l)) As properties
FROM ocorrencias As oc   ) As f )  As fc";
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

        $sql = "SELECT CAST(as_kmldoc(ST_FlipCoordinates(ponto)) AS TEXT) FROM ocorrencias";
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

        $sql = "SELECT * FROM ocorrencias WHERE id=:id";
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
            $sql = "INSERT INTO ocorrencias (bairro_id, nome, ponto, descricao)
					VALUES (:bairro, :nome, ST_GeomFromText(:ponto,4326), :descricao)";
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
    public function update($data)
    {

    }

    // Delete bairro
    public function delete($id)
    {

        $r = array();

        $sql = "DELETE FROM ocorencias WHERE id=:id";
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