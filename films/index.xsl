<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:schema="http://schema.org/">
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title><xsl:value-of select="rdf:RDF/schema:Person/schema:givenName"/></title>
                <meta name="description" content="Hi I'm {rdf:RDF/schema:Person/schema:name}."/>

                <link rel="stylesheet" href="../node_modules/modern-normalize/modern-normalize.css"/>
                <link rel="stylesheet" href="../spiffy/spiffy.css"/>
            </head>
            <body>

                <main>
                    <article>
                        <h1>Films</h1>
                        <section>
                            <table>
                                <tr>
                                    <th>Film</th>
                                    <th>Rating</th>
                                </tr>
                                <xsl:for-each select="rdf:RDF/rdf:Description[rdf:type[@rdf:resource='http://schema.org/Movie']]">
                                    <xsl:variable name="movie" select="."/>
                                    <xsl:for-each select="/rdf:RDF/rdf:Description[rdf:type[@rdf:resource='http://schema.org/Review']]">
                                        <xsl:variable name="review" select="."/>
                                        <xsl:if test="$movie/schema:review/@rdf:nodeID = @rdf:nodeID">
                                            <xsl:for-each select="/rdf:RDF/rdf:Description[rdf:type[@rdf:resource='http://schema.org/Rating']]">
                                                <xsl:if test="$review/schema:reviewRating/@rdf:nodeID = @rdf:nodeID">
                                                    <tr>
                                                        <td><a href="{$movie/schema:identifier}"><xsl:value-of select="$movie/schema:name"/></a></td>
                                                        <td><xsl:value-of select="schema:ratingValue"/></td>
                                                    </tr>
                                                </xsl:if>
                                            </xsl:for-each>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </table>
                        </section>
                    </article>
                </main>

                <footer>
                    <address>
                        Find me on <a href="https://twitter.com/veyndan">Twitter</a> and <a href="https://github.com/veyndan">GitHub</a>.
                        To get in touch, here's my <a href="mailto:{rdf:RDF/schema:Person/schema:email}">email</a>.
                    </address>
                </footer>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
