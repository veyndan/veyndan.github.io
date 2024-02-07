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

				<link rel="stylesheet" href="node_modules/modern-normalize/modern-normalize.css"/>
				<link rel="stylesheet" href="spiffy/spiffy.css"/>
			</head>
			<body>

				<main>
					<article>
						<h3>Oh shit. Ya found me. Well…</h3>
<!--						<h3>Oh shit. Ya found me. <sup>*</sup></h3>-->
<!--						<small>-->
<!--							<address>-->
<!--								<sup>*</sup> You can also find me on <a href="https://androiddev.social/@veyndan" rel="me">Mastodon</a>, <a href="https://twitter.com/veyndan" rel="me">Twitter</a>, and <a href="https://github.com/veyndan" rel="me">GitHub</a>.-->
<!--								To get in touch, here's my <a href="mailto:{root/rdf:RDF/schema:Person/schema:email}" rel="me">email</a>.-->
<!--							</address>-->
<!--						</small>-->
						<h1>Hi I'm <span class="underline">️<xsl:value-of select="root/rdf:RDF/schema:Person/schema:name"/></span>.</h1>
						<p>
							<xsl:value-of select="root/description"/>
						</p>
						<img src="profile.webp" width="1613" height="1210" alt="Me wearing sunglasses and a hoodie like a cape."/> <!-- convert profile.heic -resize 40% profile.webp-->
						<section>
							<h2>Projects</h2>
							<p>
								Ranked based on dearness to my heart,
								from very dear to pretty dear.
							</p>
							<ul>
								<xsl:for-each select="root/rdf:RDF/schema:CreativeWork">
									<li><a href="{schema:url}" style="font-weight: bold"><xsl:value-of select="schema:name"/></a> – <xsl:value-of select="schema:description"/></li>
								</xsl:for-each>
							</ul>
						</section>
						<section>
							<h2>Film Criticism</h2>
							<p>
								The cheapest form of criticism – a ranking between 1 and 10.
								At least it's more substantive than a thumbs up or down…
							</p>
							<p>
								Ranked by how recently I watched it.
							</p>
							<table>
								<tr>
									<th>Name</th>
									<th>Date</th>
									<th>Rating</th>
								</tr>
								<tr>
									<td><a href="." style="font-weight: bold">The Godfather</a></td>
									<td><date datetime="2023-01-03">2023.01.03</date></td>
									<td>9</td>
								</tr>
								<tr>
									<td><a href="." style="font-weight: bold">Community</a></td>
									<td><date datetime="2023-01-01">2023.01.01</date></td>
									<td>8</td>
								</tr>
								<tr>
									<td><a href="." style="font-weight: bold">Wadjda</a></td>
									<td><date datetime="2022-12-27">2022.12.27</date></td>
									<td>9</td>
								</tr>
								<tr>
									<td><a href="." style="font-weight: bold">Lola</a></td>
									<td><date datetime="2022-12-14">2022.12.14</date></td>
									<td>8</td>
								</tr>
								<tr>
									<td><a href="." style="font-weight: bold">Silvia Prieto</a></td>
									<td><date datetime="2022-12-3">2022.12.3</date></td>
									<td>7</td>
								</tr>
								<tr>
									<td><a href=".">More…</a></td>
								</tr>
							</table>
<!--							<p><a href=".">More…</a></p>-->
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
