echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="index.xsl"?>' > films/index.xml && tdb2.tdbdump --loc DB2 | riot --syntax N3 --output RDF/XMl >> films/index.xml
