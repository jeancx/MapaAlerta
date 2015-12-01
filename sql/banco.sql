
CREATE TABLE bairros
(
	id serial NOT NULL,
	nome character varying(255),
	PRIMARY KEY (id)
);
SELECT AddGeometryColumn (
 'public',--nome do schema
 'bairros', --nome da tabela
 'poligono', --nome da coluna
 4326, --SRID
 'POLYGON', --tipo da geometria
 2 -- X,Y
);

CREATE TABLE ocorrencias
(
	id SERIAL NOT NULL,
	bairro_id INTEGER,
	nome character varying(255),
	descricao TEXT,
	PRIMARY KEY (id),
	FOREIGN KEY (bairro_id) REFERENCES bairros (id)
);

SELECT AddGeometryColumn (
 'public',--nome do schema
 'ocorrencias', --nome da tabela
 'ponto', --nome da coluna
 4326, --SRID
 'POINT', --tipo da geometria
 2 -- X,Y
);



/* Fonte: http://blog.mackerron.com/2010/09/29/as_kmldoc/ */
CREATE OR REPLACE FUNCTION xml_escape(TEXT)
RETURNS TEXT AS $$
  SELECT replace(replace(replace($1, '&', '&amp;'), '<', '&lt;'), '>', '&gt;');
$$ LANGUAGE sql IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION kml_wrap(TEXT)
RETURNS TEXT AS $$
  SELECT
    '<kml xmlns="http://www.opengis.net/kml/2.2"><Document>'
    || $1 || '</Document></kml>';
$$ LANGUAGE sql IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION kml_concat(TEXT, geometry)
RETURNS TEXT AS $$
  SELECT $1 || '<Placemark>' || st_askml($2) || '</Placemark>';
$$ LANGUAGE sql IMMUTABLE STRICT;

CREATE AGGREGATE as_kmldoc(geometry) (
    sfunc = kml_concat,
    finalfunc = kml_wrap,
    stype = TEXT,
    initcond = ''
);

CREATE OR REPLACE FUNCTION kml_concat(TEXT, geometry, anyelement)
RETURNS TEXT AS $$
  SELECT $1 || '<Placemark><name>' || xml_escape(cast($3 AS TEXT)) || '</name>'
  || st_askml($2) || '</Placemark>';
$$ LANGUAGE sql IMMUTABLE STRICT;

CREATE AGGREGATE as_kmldoc(geometry, anyelement) (
    sfunc = kml_concat,
    finalfunc = kml_wrap,
    stype = TEXT,
    initcond = ''
);

CREATE OR REPLACE FUNCTION kml_concat(TEXT, geometry, anyelement, anyelement)
RETURNS TEXT AS $$
  SELECT $1 || '<Placemark><name>' || xml_escape(cast($3 AS TEXT))
  || '</name><description>' || xml_escape(cast($4 AS TEXT))
  || '</description>' || st_askml($2) || '</Placemark>';
$$ LANGUAGE sql IMMUTABLE STRICT;

CREATE AGGREGATE as_kmldoc(geometry, anyelement, anyelement) (
    sfunc = kml_concat,
    finalfunc = kml_wrap,
    stype = TEXT,
    initcond = ''
);

CREATE OR REPLACE FUNCTION join_kmldocs(VARIADIC TEXT[])
RETURNS TEXT AS $$
  SELECT kml_wrap(
    replace(
      replace(
        ARRAY_TO_STRING($1, ''),
        '<kml xmlns="http://www.opengis.net/kml/2.2"><Document>',
        '<Folder>'
       ),
       '</Document></kml>',
       '</Folder>'
    )
  );
$$ LANGUAGE sql IMMUTABLE STRICT;


SELECT as_kmldoc(polygon) FROM tabela;
SELECT as_kmldoc(location, NAME, code) FROM tabela;