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
				<link rel="stylesheet" href="/index.css"/>
			</head>
			<body>

				<header>
					<nav>
						<ul>
							<li>
								<a href="/index.xml" aria-current="page">
									<img
										src="{root/rdf:RDF/schema:Person/schema:image/schema:contentUrl}"
										width="{root/rdf:RDF/schema:Person/schema:image/schema:width/schema:value}"
										height="{root/rdf:RDF/schema:Person/schema:image/schema:width/schema:value}"
										alt=""
									/>
									<div>
										<span>Veyndan 🌱🏳️‍🌈</span>
										<span>My little corner of the internet.</span>
									</div>
								</a>
							</li>
							<li><a href="/projects/index.xml">Projects</a></li>
						</ul>
					</nav>
				</header>

				<main>
					<h1>Hi I'm <span class="underline">️<xsl:value-of select="root/rdf:RDF/schema:Person/schema:name"/></span><sup style="font-size: 1.2rem;"> 1</sup>.</h1>
					<p style="margin-top: -1rem;margin-bottom: 1.5rem;font-size: .75rem;font-style: italic;"><sup>1 </sup><a href="/pronunciation.mp3">How do you pronounce that?</a></p>
					<p>
						<xsl:value-of select="root/description"/>
					</p>
					<img
						srcset="
							hoodie-640w.webp 640w,
							hoodie-1024w.webp 1024w,
							hoodie-1920w.webp 1920w,
						"
						src="hoodie-1920w.webp"
						width="1920"
						height="1440"
						alt="Me wearing sunglasses and a hoodie like a cape."
					/> <!-- convert profile.heic -resize 40% profile.webp-->
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
