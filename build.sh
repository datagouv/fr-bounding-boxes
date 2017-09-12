#!/bin/bash

# Variables
ADMIN_EXPRESS_URL="https://wxs-telechargement.ign.fr/x02uy2aiwjo9bm8ce5plwqmr/telechargement/prepackage/ADMINEXPRESS-COG-PACK_2017-07-07\$ADMIN-EXPRESS-COG_1-0__SHP__FRA_2017-06-19/file/ADMIN-EXPRESS-COG_1-0__SHP__FRA_2017-06-19.7z"
ADMIN_EXPRESS_FILENAME="ADMIN-EXPRESS-COG_1-0__SHP__FRA_2017-06-19.7z"

# Initialisation
rm -Rf tmp
rm -Rf dist
mkdir -p data
mkdir tmp
mkdir dist

# Téléchargement des données ADMIN Express COG 2017
wget -N -P data/ $ADMIN_EXPRESS_URL

# Extraction de l'archive
mkdir tmp/ADMIN-EXPRESS.decompressed
unar -o tmp/ADMIN-EXPRESS.decompressed/ -no-directory data/$ADMIN_EXPRESS_FILENAME

# Extraction des limites administrative au format GeoJSON (newline delimited)
echo "Extraction des communes au format GeoJSON"
find tmp/ADMIN-EXPRESS.decompressed -name COMMUNE.shp -exec sh -c "ogr2ogr -f GeoJSON -t_srs EPSG:4326 /vsistdout/ {} | ./node_modules/.bin/geojson2ndjson >> tmp/ADMIN-EXPRESS-COMMUNE.ndjson" \;
echo "Extraction des EPCI au format GeoJSON"
find tmp/ADMIN-EXPRESS.decompressed -name EPCI.shp -exec sh -c "ogr2ogr -f GeoJSON -t_srs EPSG:4326 /vsistdout/ {} | ./node_modules/.bin/geojson2ndjson >> tmp/ADMIN-EXPRESS-EPCI.ndjson" \;
echo "Extraction des départements au format GeoJSON"
find tmp/ADMIN-EXPRESS.decompressed -name DEPARTEMENT.shp -exec sh -c "ogr2ogr -f GeoJSON -t_srs EPSG:4326 /vsistdout/ {} | ./node_modules/.bin/geojson2ndjson >> tmp/ADMIN-EXPRESS-DEPARTEMENT.ndjson" \;
echo "Extraction des régions au format GeoJSON"
find tmp/ADMIN-EXPRESS.decompressed -name REGION.shp -exec sh -c "ogr2ogr -f GeoJSON -t_srs EPSG:4326 /vsistdout/ {} | ./node_modules/.bin/geojson2ndjson >> tmp/ADMIN-EXPRESS-REGION.ndjson" \;

# Construction des bboxes
echo "Construction des bboxes"
cat tmp/ADMIN-EXPRESS-COMMUNE.ndjson | node bbox > dist/communes.json
cat tmp/ADMIN-EXPRESS-EPCI.ndjson | node bbox > dist/epci.json
cat tmp/ADMIN-EXPRESS-DEPARTEMENT.ndjson | node bbox > dist/departements.json
cat tmp/ADMIN-EXPRESS-REGION.ndjson | node bbox > dist/regions.json

# Nettoyage
rm -Rf tmp

echo "Terminé"
