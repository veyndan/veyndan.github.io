self.addEventListener('install', (e) => {
	e.waitUntil(
		caches.open('veyndan-store').then((cache) => cache.addAll([
			'/',
			'/index.xml',
			'/index.xsl',
			'/index.js',
		])),
	);
});

self.addEventListener('fetch', (e) => {
	console.log(e.request.url);
	e.respondWith(
		caches.match(e.request).then((response) => response || fetch(e.request)),
	);
});
