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
				<link rel="stylesheet" href="/spiffy/spiffy.css"/>

				<style>
					header > nav > ul > li > a[href="/index.xml"] {
						position: relative;
						color: inherit;
						text-decoration: inherit;
						text-transform: lowercase;
						font-weight: bold;
						background-image: linear-gradient(
							to bottom right,
							rgb(214 2 112 / .6),
							37%,
							rgb(155 79 150 / .6) 43%,
							63%,
							rgb(0 56 168 / .6) 75%
						);
						border-radius: 1em 0;
						padding: .5rem 1rem;
					}
				</style>
			</head>
			<body>

				<header>
					<nav>
						<ul>
							<li><a href="/index.xml">Veyndan</a></li>
							<li><a href="/projects/index.xml" aria-current="page">Projects</a></li>
						</ul>
					</nav>
				</header>

				<main>
					<article>
						<h1>Projects</h1>
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
					<article>
						<h2>Awards</h2>
						<ul>
							<li>
								<p>A winner of the <a href="https://opensource.googleblog.com/2023/12/google-open-source-peer-bonus-program-announces-second-group-of-2023-winners.html">2023 Google Open Source Peer Bonus Program</a> for <a href="https://developer.android.com/jetpack/androidx/releases/paging#3.3.0-alpha02">helping bring</a> Kotlin/Multiplatform compatibility to the AndroidX Paging library.</p>
							</li>
						</ul>
					</article>
				</main>

				<footer>
					<address>
						Find me on <a href="https://androiddev.social/@veyndan" rel="me">Mastodon</a> and <a href="https://github.com/veyndan" rel="me">GitHub</a>.
						To get in touch, <a href="mailto:{root/rdf:RDF/schema:Person/schema:email}" rel="me">email me</a> or <a href="https://matrix.to/#/@veyndan:matrix.org">message me on Matrix</a>.
					</address>
				</footer>

			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
