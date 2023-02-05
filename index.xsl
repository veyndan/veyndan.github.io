<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:schema="http://schema.org/">
	<xsl:template match="/">
		<html lang="en">
<!--			curl https://storage.inrupt.com/5706ca56-c041-4000-a42f-3927b62cba8c/movies/ | rapper -/-input turtle -/-output rdfxml - https://storage.input.com-->
			<head>
				<meta charset="UTF-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
				<title><xsl:value-of select="root/rdf:RDF/schema:Person/schema:givenName"/></title>
				<meta name="author" content="{root/rdf:RDF/schema:Person/schema:name}"/>
				<meta name="description" content="{root/description}"/>

<!--				Should I use a CDN here instead? Probably will resolve faster. I'd like to be able to version it still though in package.json. -->
<!--				Side benefit that won't last long is that I can remove the special case about node_modules in .gitignore as I won't have any node modules. -->
<!--				Is there a better normalize.css out there that's actually maintained? I like the "modern" part of the normalize though.-->
<!--				<link rel="stylesheet" href="node_modules/modern-normalize/modern-normalize.css"/>-->
				<link rel="stylesheet" href="spiffy/spiffy.css"/>
			</head>
			<body>

				<main>
					<h3>Oh shit. Ya found me. Well…</h3>
					<h1>Hi I'm <span class="underline" contenteditable="true" placeholder="Name">️<xsl:value-of select="root/rdf:RDF/schema:Person/schema:name"/></span>.</h1>
<!--						<h3>Oh shit. Ya found me. <sup>*</sup></h3>-->
<!--						<small>-->
<!--							<address>-->
<!--								<sup>*</sup> You can also find me on <a href="https://androiddev.social/@veyndan" rel="me">Mastodon</a>, <a href="https://twitter.com/veyndan" rel="me">Twitter</a>, and <a href="https://github.com/veyndan" rel="me">GitHub</a>.-->
<!--								To get in touch, here's my <a href="mailto:{root/rdf:RDF/schema:Person/schema:email}" rel="me">email</a>.-->
<!--							</address>-->
<!--						</small>-->
					<p>
						<xsl:value-of select="root/description"/>
					</p>
<!--						<figure>-->
<!--							<img src="profile.webp" width="1613" height="1210" alt="Me wearing sunglasses and a hoodie like a cape."/> &lt;!&ndash; convert profile.heic -resize 40% profile.webp&ndash;&gt;-->
<!--							<figcaption>I'm not like the other tech bros.</figcaption>-->
<!--							<figcaption>Figuring out the <a href="https://readwrite.com/soma-street-style-hbo-silicon-valley/">brogrammer attire</a>.</figcaption>-->
<!--						</figure>-->

<!--						This is a cool idea.
							It can be paired with the 'Network Information API', so on higher connection you get the full image, and on lower connection you get the SVG.
							Also something like that website where "if there is a heavy load on the electrical network, then show the SVG, otherwise show the full image".
							This relies on the SVG being significantly smaller than the PNG, which it currently isn't (95kb vs 120kb).
							I'd want to simplify the SVG anyway, as I'm sure a load of data is about getting the blades of grass.
							I'd want to 'magic wand' it in Photoshop anyway to add back the clouds (and add same facial structure, so I look less like a condom).
-->
<!--						<img src="profile.svg" width="1613" height="1210" alt="Me wearing sunglasses and a hoodie like a cape."/> &lt;!&ndash; convert profile.heic -resize 40% profile.webp&ndash;&gt;-->
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
						<h1>Projects</h1>
						<p>
							Ranked based on dearness to my heart,
							from very dear to pretty dear.
						</p>
						<ul contenteditable="true">
							<xsl:for-each select="root/rdf:RDF/schema:CreativeWork">
								<li><a href="{schema:url}" style="font-weight: bold"><xsl:value-of select="schema:name"/></a> – <xsl:value-of select="schema:description"/></li>
							</xsl:for-each>
						</ul>
					</article>
					<article>
						<h1>Photos</h1>
						<!-- This doesn't work in Chrome -->
						<section class="justified-gallery">
							<img src="https://assets.codepen.io/12005/windmill.jpg" style="--width: 768; --height: 1024" width="768" height="1024" alt="A windmill"/>
							<img src="https://assets.codepen.io/12005/suspension-bridge.jpg" style="--width: 1024; --height: 683" width="1024" height="683" alt="The Clifton Suspension Bridge"/>
							<img src="https://assets.codepen.io/12005/sunset.jpg" style="--width: 1024; --height: 768" width="1024" height="768" alt="Sunset and boats"/>
							<img src="https://assets.codepen.io/12005/snowy.jpg" style="--width: 1024; --height: 683" width="1024" height="683" alt="a river in the snow"/>
							<img src="https://assets.codepen.io/12005/bristol-balloons1.jpg" style="--width: 1024; --height: 683" width="1024" height="683" alt="a single checked balloon"/>
							<img src="https://assets.codepen.io/12005/dog-balloon.jpg" style="--width: 768; --height: 1024" width="768" height="1024" alt="a hot air balloon shaped like a dog"/>
							<img src="https://assets.codepen.io/12005/abq-balloons.jpg" style="--width: 1024; --height: 683" width="1024" height="683" alt="View from a hot air balloon of other balloons"/>
							<img src="https://assets.codepen.io/12005/disney-balloon.jpg" style="--width: 768; --height: 1024" width="768" height="1024" alt="a balloon fairground ride"/>
							<img src="https://assets.codepen.io/12005/bristol-harbor.jpg" style="--width: 1024; --height: 768" width="1024" height="768" alt="sunrise over a harbor"/>
						</section>
					</article>
					<article>
						<h1>Film &amp; TV Ratings</h1>
						<p>
							The cheapest form of criticism – a ranking between 1 and 10.
							At least it's more substantive than a thumbs up or down…
						</p>
						<p>
							Ranked by how recently I watched it.
						</p>
						<table>
							<thead>
								<tr>
									<th scope="col">Name</th>
									<th scope="col">Date</th>
									<th scope="col">Rating</th>
								</tr>
							</thead>
							<tbody>
								<xsl:for-each select="root/rdf:RDF/schema:Movie">
									<tr>
										<td><a href="." style="font-weight: bold"><xsl:value-of select="schema:name"/></a></td>
										<td><time datetime="{schema:review/schema:dateCreated}"><xsl:value-of select="schema:review/schema:dateCreated"/></time></td>
										<td><xsl:value-of select="schema:review/schema:rating/schema:ratingValue"/></td>
									</tr>
								</xsl:for-each>
								<tr>
									<td><a href=".">More…</a></td>
								</tr>
							</tbody>
						</table>
<!--							<p><a href=".">More…</a></p>-->
					</article>
					<article>
						<h1>YouTube</h1>
					</article>
					<article>
						<h1>Bookmarks</h1>
						<p>
							My browser bookmarks are a mess.
						</p>
					</article>
					<article>
						<h1>Mastodon Posts</h1>
						<p>
							Hacker News is the only social media I consistently use.
							Mastodon's the only social media I want to succeed.
							I am a tad hypocritical as I'm still on Twitter,
							and I haven't deleted my Facebook account.
						</p>
						<p>
							Here's a list of my posts in chronological order.
						</p>
					</article>
					<article>
						<h1>Linked List</h1>
						<p>
							<a href="http://octopress.org/docs/blogging/linklog/">Explanation.</a>
						</p>
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
