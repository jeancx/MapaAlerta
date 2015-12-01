<?php

use lib\Config;

// Configurações do Banco de Dados POSTGRESQL
Config::write('db.host', 'localhost');
Config::write('db.port', '5432');
Config::write('db.basename', 'mapa_alerta2');
Config::write('db.user', 'postgres');
Config::write('db.password', 'root');

// Endereço Publico do Projeto
Config::write('path', 'http://'.$_SERVER['HTTP_HOST'].'/MapaAlerta/public');

