'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-maskable-192.png": "b3b7b3c64c29505b30f9fe92b0eae501",
"icons/Icon-192.png": "5ceb44e3d084c82d521754febd44b407",
"icons/Icon-maskable-512.png": "8f17a5f3a1945887358e3a610e65ca85",
"icons/Icon-512.png": "6fc41aeb52e640205bddb9618322684b",
"sqlite3.wasm": "d9fe0deaa4703e3ce03614741774735b",
"assets/fonts/MaterialIcons-Regular.otf": "f861ec5ee8e6f8fa38036bfbc61484c7",
"assets/AssetManifest.bin.json": "bd3ccbc6248441d596dcbb6dc4d5df0e",
"assets/AssetManifest.bin": "aba5e99353bab4844dbf54793e9dc2d0",
"assets/AssetManifest.json": "ca594a898a9d0200b089a218ceceb520",
"assets/assets/www/styles/fonts.css": "7ea57b647a323b82c94a1138892461cd",
"assets/assets/www/scripts/scrolling.js": "b66182657ecc5d7ecdb9fe452cefb8b1",
"assets/assets/google_fonts/Literata-ExtraBold.ttf": "9fb10cccfee4b8e8c1b05dee73979e72",
"assets/assets/google_fonts/Lato-BoldItalic.ttf": "acc03ac1e9162f0388c005177d55d762",
"assets/assets/google_fonts/Lato-Italic.ttf": "5d22f337a040ae2857e36e7c5800369b",
"assets/assets/google_fonts/Newsreader-Medium.ttf": "62bf84d7f16c59284e66ad8da41c1179",
"assets/assets/google_fonts/Newsreader-ExtraBoldItalic.ttf": "83182a36b1bf0afc7a14103937aec9df",
"assets/assets/google_fonts/Montserrat-Thin.ttf": "b3638b16904211d1d24d04ce53810c4d",
"assets/assets/google_fonts/Lato-Black.ttf": "d83ab24f5cf2be8b7a9873dd64f6060a",
"assets/assets/google_fonts/Newsreader-SemiBoldItalic.ttf": "db4515c10af798a288f9dcec61a32243",
"assets/assets/google_fonts/Lato-Bold.ttf": "24b516c266d7341c954cb2918f1c8f38",
"assets/assets/google_fonts/Montserrat-ExtraBold.ttf": "9e07cac927a9b4d955e2138bf6136d6a",
"assets/assets/google_fonts/Montserrat-Bold.ttf": "ed86af2ed5bbaf879e9f2ec2e2eac929",
"assets/assets/google_fonts/Montserrat-BlackItalic.ttf": "a67f4df02f4d73bb8bfd5bff421e4d1f",
"assets/assets/google_fonts/Lato-ThinItalic.ttf": "2b26bc77c3f9432c9d4ca4911520294d",
"assets/assets/google_fonts/Newsreader-Regular.ttf": "8f95e499462a81a8490b0fb3c37bacb6",
"assets/assets/google_fonts/Newsreader-MediumItalic.ttf": "bbe4169beb7c7df29d9e15071f5bb1d2",
"assets/assets/google_fonts/Newsreader-Light.ttf": "1d8468ca33fe47ad9967eaaee5ad1bbb",
"assets/assets/google_fonts/Literata-MediumItalic.ttf": "7e009f2aab98a4da6606f9b456d470f3",
"assets/assets/google_fonts/Montserrat-SemiBold.ttf": "cc10461cb5e0a6f2621c7179f4d6de17",
"assets/assets/google_fonts/Montserrat-Regular.ttf": "5e077c15f6e1d334dd4e9be62b28ac75",
"assets/assets/google_fonts/Literata-Medium.ttf": "8aec17fc48f5c524d2be8f99c665d6fc",
"assets/assets/google_fonts/Lato-BlackItalic.ttf": "047217f671c9e0849c97d43e26543046",
"assets/assets/google_fonts/AtkinsonHyperlegible-Bold.ttf": "08fc19673abeac2cafa733008e8662f1",
"assets/assets/google_fonts/Literata-ExtraLightItalic.ttf": "9e0cd060c0620a279b96c9e963e6ebcf",
"assets/assets/google_fonts/Montserrat-Italic.ttf": "cc53ad8bb1c801746c831bb7ce493f74",
"assets/assets/google_fonts/Montserrat-Light.ttf": "94fbe93542f684134cad1d775947ca92",
"assets/assets/google_fonts/Newsreader-Bold.ttf": "373c4398a5a6aef2c28ba8b3dc1f05d6",
"assets/assets/google_fonts/Montserrat-ExtraBoldItalic.ttf": "8a4a6844448e210672d54f8b32932ee9",
"assets/assets/google_fonts/OFL.txt": "351d297640ae0bc1b0e63946897ebeb9",
"assets/assets/google_fonts/Newsreader-ExtraBold.ttf": "72f3d4bf097b8b089aeb5661acd91f79",
"assets/assets/google_fonts/Literata-SemiBold.ttf": "593d9465156bbf0665015d6f37bf2071",
"assets/assets/google_fonts/Literata-BlackItalic.ttf": "8e35bbef2bd7cdeb65f4d65198416384",
"assets/assets/google_fonts/Newsreader-ExtraLight.ttf": "2449f6d64917a8f4890bac2e54ea439f",
"assets/assets/google_fonts/Literata-ExtraBoldItalic.ttf": "939c681b05f5a5d25b1f7405ea8318bd",
"assets/assets/google_fonts/Lato-Regular.ttf": "122dd68d69fe9587e062d20d9ff5de2a",
"assets/assets/google_fonts/Literata-Italic.ttf": "a5b7fb33ac4290b7d13ceb13dcbf4eff",
"assets/assets/google_fonts/Montserrat-SemiBoldItalic.ttf": "75c4176c64611f32faf01a5de7631877",
"assets/assets/google_fonts/AtkinsonHyperlegible-BoldItalic.ttf": "a18eedb73a9ff74da81c1885bc57b779",
"assets/assets/google_fonts/AtkinsonHyperlegible-Regular.ttf": "28147924c6c58c46f245a75ebf336a53",
"assets/assets/google_fonts/Montserrat-BoldItalic.ttf": "a49032b6a945b021303f16b664f87e6c",
"assets/assets/google_fonts/Newsreader-LightItalic.ttf": "bc3dfc93ee8516f517b55655ca505958",
"assets/assets/google_fonts/Literata-Black.ttf": "be90196ffd7543c959b61a3cf670f908",
"assets/assets/google_fonts/AtkinsonHyperlegible-Italic.ttf": "163da8d6ac918cef1e8ffd56a33849c4",
"assets/assets/google_fonts/Literata-Regular.ttf": "daa6877e49c61342395940af4ca224ea",
"assets/assets/google_fonts/Montserrat-ThinItalic.ttf": "ff9c45e92d16324b8964447d12d1f458",
"assets/assets/google_fonts/Literata-BoldItalic.ttf": "cb1451a2b5570f892043a9f24a7b3d4c",
"assets/assets/google_fonts/Newsreader-Italic.ttf": "a27bed043c140204b7d9fa96fd0645f6",
"assets/assets/google_fonts/Lato-Light.ttf": "2bcc211c05fc425a57b2767a4cdcf174",
"assets/assets/google_fonts/Literata-ExtraLight.ttf": "c0f9ca745b2e9343bfc3f0a0c9bc74d4",
"assets/assets/google_fonts/Lato-LightItalic.ttf": "2404a6da847c878edbc8280745365cba",
"assets/assets/google_fonts/Newsreader-SemiBold.ttf": "28687ad1caaae75474651cfcdb502b1c",
"assets/assets/google_fonts/Literata-SemiBoldItalic.ttf": "b076269bd282cd28655da02c1f295c48",
"assets/assets/google_fonts/Montserrat-LightItalic.ttf": "c54486c33610a1fca147afc18af3034f",
"assets/assets/google_fonts/Newsreader-BoldItalic.ttf": "990574635e3de7dd3f7231883f287010",
"assets/assets/google_fonts/Montserrat-ExtraLightItalic.ttf": "9c3e2f21cc8fba26dc3da67e89a9365d",
"assets/assets/google_fonts/Lato-Thin.ttf": "7ab0bc06eecc1b75f8708aba3d3b044a",
"assets/assets/google_fonts/Montserrat-Black.ttf": "cce7ff8c1d7999f907b6760fbe75d99d",
"assets/assets/google_fonts/Literata-LightItalic.ttf": "db76e1f244efb24e254d3d95bde4515f",
"assets/assets/google_fonts/Literata-Bold.ttf": "be6a3cf0a997a0ef54c5ee91d979c0e1",
"assets/assets/google_fonts/Montserrat-ExtraLight.ttf": "a7fe50578d9aa3966c925cb9722db03a",
"assets/assets/google_fonts/Literata-Light.ttf": "7be965a6187fc04a61aeb93487804636",
"assets/assets/google_fonts/Montserrat-Medium.ttf": "bdb7ba651b7bdcda6ce527b3b6705334",
"assets/assets/google_fonts/Newsreader-ExtraLightItalic.ttf": "c88e03395c65b041b7f47d8369ecbcb2",
"assets/assets/google_fonts/Montserrat-MediumItalic.ttf": "2ed625fc9f039d801a5aab9b6f9cd8ef",
"assets/assets/google_fonts/source.txt": "e833b564982f257914d431c58bcb58f3",
"assets/assets/article.template.html": "7aa3c0d42f2a7157af1ea1df57907225",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "ee770ab61599c82010d317b287a6b9dd",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "6a4139971a8c5ce566d7d72b51d5b605",
"main.dart.js": "2a332c9d7a5c3e746f44ee2ae7a9cbc8",
"manifest.json": "cd7438b257d41690d320142f93462c27",
"drift_worker.js": "babb348cf72e6da955c4386f67316e28",
"version.json": "0351f2f681def5caba2c2b3553e23b05",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"flutter_bootstrap.js": "537701ba000736a9355821251bd3f653",
"favicon.png": "bd2ffdc623d7cedcc6df7e716746dd8e",
"index.html": "6058897460d6c039ae26a0dcf0298bed",
"/": "6058897460d6c039ae26a0dcf0298bed",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
