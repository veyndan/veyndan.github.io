<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:schema="http://schema.org/">
	<xsl:template match="/">
		<html lang="en">
			<head>
				<meta charset="UTF-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
				<title><xsl:value-of select="root/rdf:RDF/schema:Person/schema:givenName"/></title>
				<meta name="author" content="{root/rdf:RDF/schema:Person/schema:name}"/>
				<meta name="description" content="{root/description}"/>

				<script src="index.js" defer="true"/>

				<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png"/>
				<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png"/>
				<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png"/>
				<link rel="manifest" href="manifest.webmanifest"/>
				<link rel="stylesheet" href="spiffy/spiffy.css"/>
			</head>
			<body>

				<main>
					<h3>Ya found me.</h3>
					<h1>Hi I'm <span class="underline">️<xsl:value-of select="root/rdf:RDF/schema:Person/schema:name"/></span>.</h1>
					<p>
						<xsl:value-of select="root/description"/>
					</p>
					<img
						srcset="
							profile-640w.webp 640w,
							profile-1024w.webp 1024w,
							profile-1920w.webp 1920w,
						"
						src="profile-1920w.webp"
						width="1920"
						height="1440"
						alt="Me wearing sunglasses and a hoodie like a cape."
					/> <!-- convert profile.heic -resize 40% profile.webp-->
					<article>
						<h2>Projects</h2>
						<p>
							Ranked based on dearness to my heart,
							from very dear to pretty dear.
						</p>
						<section>
							<h5>Authored</h5>
							<ul>
								<xsl:for-each select="root/rdf:RDF/schema:CreativeWork[schema:author]">
									<li><a href="{schema:url}" style="font-weight: bold"><xsl:value-of select="schema:name"/></a> – <xsl:value-of select="schema:description"/></li>
								</xsl:for-each>
							</ul>
						</section>
						<section>
							<h5>Contributed</h5>
							<ul>
								<xsl:for-each select="root/rdf:RDF/schema:CreativeWork[not(schema:author)]">
									<li><a href="{schema:url}" style="font-weight: bold"><xsl:value-of select="schema:name"/></a> – <xsl:value-of select="schema:description"/></li>
								</xsl:for-each>
							</ul>
						</section>
					</article>
				</main>

				<footer>
					<address>
						Find me on <a href="https://androiddev.social/@veyndan" rel="me">Mastodon</a>, <a href="https://twitter.com/veyndan" rel="me">Twitter</a>, and <a href="https://github.com/veyndan" rel="me">GitHub</a>.
						To get in touch, here's my <a href="mailto:{root/rdf:RDF/schema:Person/schema:email}" rel="me">email</a>.
					</address>
				</footer>

			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
