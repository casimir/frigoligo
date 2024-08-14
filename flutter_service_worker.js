'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "e5df975d528d6b3d5af7cc0ca2a9498d",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/assets/google_fonts/Lato-BoldItalic.ttf": "acc03ac1e9162f0388c005177d55d762",
"assets/assets/google_fonts/Lato-BlackItalic.ttf": "047217f671c9e0849c97d43e26543046",
"assets/assets/google_fonts/Newsreader-ExtraBold.ttf": "72f3d4bf097b8b089aeb5661acd91f79",
"assets/assets/google_fonts/Montserrat-Light.ttf": "94fbe93542f684134cad1d775947ca92",
"assets/assets/google_fonts/Lato-LightItalic.ttf": "2404a6da847c878edbc8280745365cba",
"assets/assets/google_fonts/Newsreader-Italic.ttf": "a27bed043c140204b7d9fa96fd0645f6",
"assets/assets/google_fonts/AtkinsonHyperlegible-Bold.ttf": "08fc19673abeac2cafa733008e8662f1",
"assets/assets/google_fonts/Newsreader-Regular.ttf": "8f95e499462a81a8490b0fb3c37bacb6",
"assets/assets/google_fonts/Literata-Regular.ttf": "daa6877e49c61342395940af4ca224ea",
"assets/assets/google_fonts/Literata-Medium.ttf": "8aec17fc48f5c524d2be8f99c665d6fc",
"assets/assets/google_fonts/Literata-MediumItalic.ttf": "7e009f2aab98a4da6606f9b456d470f3",
"assets/assets/google_fonts/Lato-Light.ttf": "2bcc211c05fc425a57b2767a4cdcf174",
"assets/assets/google_fonts/Literata-LightItalic.ttf": "db76e1f244efb24e254d3d95bde4515f",
"assets/assets/google_fonts/Montserrat-SemiBoldItalic.ttf": "75c4176c64611f32faf01a5de7631877",
"assets/assets/google_fonts/Newsreader-SemiBold.ttf": "28687ad1caaae75474651cfcdb502b1c",
"assets/assets/google_fonts/Montserrat-Black.ttf": "cce7ff8c1d7999f907b6760fbe75d99d",
"assets/assets/google_fonts/AtkinsonHyperlegible-BoldItalic.ttf": "a18eedb73a9ff74da81c1885bc57b779",
"assets/assets/google_fonts/Lato-Regular.ttf": "122dd68d69fe9587e062d20d9ff5de2a",
"assets/assets/google_fonts/Literata-Light.ttf": "7be965a6187fc04a61aeb93487804636",
"assets/assets/google_fonts/Literata-Black.ttf": "be90196ffd7543c959b61a3cf670f908",
"assets/assets/google_fonts/Lato-ThinItalic.ttf": "2b26bc77c3f9432c9d4ca4911520294d",
"assets/assets/google_fonts/Montserrat-BoldItalic.ttf": "a49032b6a945b021303f16b664f87e6c",
"assets/assets/google_fonts/Literata-BlackItalic.ttf": "8e35bbef2bd7cdeb65f4d65198416384",
"assets/assets/google_fonts/Montserrat-LightItalic.ttf": "c54486c33610a1fca147afc18af3034f",
"assets/assets/google_fonts/Newsreader-ExtraBoldItalic.ttf": "83182a36b1bf0afc7a14103937aec9df",
"assets/assets/google_fonts/Montserrat-Bold.ttf": "ed86af2ed5bbaf879e9f2ec2e2eac929",
"assets/assets/google_fonts/Montserrat-Thin.ttf": "b3638b16904211d1d24d04ce53810c4d",
"assets/assets/google_fonts/Montserrat-Italic.ttf": "cc53ad8bb1c801746c831bb7ce493f74",
"assets/assets/google_fonts/Montserrat-Medium.ttf": "bdb7ba651b7bdcda6ce527b3b6705334",
"assets/assets/google_fonts/OFL.txt": "351d297640ae0bc1b0e63946897ebeb9",
"assets/assets/google_fonts/Lato-Italic.ttf": "5d22f337a040ae2857e36e7c5800369b",
"assets/assets/google_fonts/Lato-Thin.ttf": "7ab0bc06eecc1b75f8708aba3d3b044a",
"assets/assets/google_fonts/Montserrat-ExtraBoldItalic.ttf": "8a4a6844448e210672d54f8b32932ee9",
"assets/assets/google_fonts/Literata-ExtraBoldItalic.ttf": "939c681b05f5a5d25b1f7405ea8318bd",
"assets/assets/google_fonts/Literata-BoldItalic.ttf": "cb1451a2b5570f892043a9f24a7b3d4c",
"assets/assets/google_fonts/Newsreader-Medium.ttf": "62bf84d7f16c59284e66ad8da41c1179",
"assets/assets/google_fonts/Newsreader-MediumItalic.ttf": "bbe4169beb7c7df29d9e15071f5bb1d2",
"assets/assets/google_fonts/Montserrat-ExtraLightItalic.ttf": "9c3e2f21cc8fba26dc3da67e89a9365d",
"assets/assets/google_fonts/Literata-Bold.ttf": "be6a3cf0a997a0ef54c5ee91d979c0e1",
"assets/assets/google_fonts/Literata-SemiBold.ttf": "593d9465156bbf0665015d6f37bf2071",
"assets/assets/google_fonts/Literata-Italic.ttf": "a5b7fb33ac4290b7d13ceb13dcbf4eff",
"assets/assets/google_fonts/Newsreader-LightItalic.ttf": "bc3dfc93ee8516f517b55655ca505958",
"assets/assets/google_fonts/Lato-Bold.ttf": "24b516c266d7341c954cb2918f1c8f38",
"assets/assets/google_fonts/Newsreader-ExtraLightItalic.ttf": "c88e03395c65b041b7f47d8369ecbcb2",
"assets/assets/google_fonts/Literata-ExtraLightItalic.ttf": "9e0cd060c0620a279b96c9e963e6ebcf",
"assets/assets/google_fonts/Montserrat-ThinItalic.ttf": "ff9c45e92d16324b8964447d12d1f458",
"assets/assets/google_fonts/source.txt": "e833b564982f257914d431c58bcb58f3",
"assets/assets/google_fonts/Montserrat-ExtraLight.ttf": "a7fe50578d9aa3966c925cb9722db03a",
"assets/assets/google_fonts/Newsreader-Light.ttf": "1d8468ca33fe47ad9967eaaee5ad1bbb",
"assets/assets/google_fonts/AtkinsonHyperlegible-Italic.ttf": "163da8d6ac918cef1e8ffd56a33849c4",
"assets/assets/google_fonts/Montserrat-SemiBold.ttf": "cc10461cb5e0a6f2621c7179f4d6de17",
"assets/assets/google_fonts/Literata-SemiBoldItalic.ttf": "b076269bd282cd28655da02c1f295c48",
"assets/assets/google_fonts/Montserrat-ExtraBold.ttf": "9e07cac927a9b4d955e2138bf6136d6a",
"assets/assets/google_fonts/Montserrat-MediumItalic.ttf": "2ed625fc9f039d801a5aab9b6f9cd8ef",
"assets/assets/google_fonts/Newsreader-BoldItalic.ttf": "990574635e3de7dd3f7231883f287010",
"assets/assets/google_fonts/Montserrat-Regular.ttf": "5e077c15f6e1d334dd4e9be62b28ac75",
"assets/assets/google_fonts/Literata-ExtraLight.ttf": "c0f9ca745b2e9343bfc3f0a0c9bc74d4",
"assets/assets/google_fonts/Newsreader-Bold.ttf": "373c4398a5a6aef2c28ba8b3dc1f05d6",
"assets/assets/google_fonts/AtkinsonHyperlegible-Regular.ttf": "28147924c6c58c46f245a75ebf336a53",
"assets/assets/google_fonts/Lato-Black.ttf": "d83ab24f5cf2be8b7a9873dd64f6060a",
"assets/assets/google_fonts/Newsreader-SemiBoldItalic.ttf": "db4515c10af798a288f9dcec61a32243",
"assets/assets/google_fonts/Literata-ExtraBold.ttf": "9fb10cccfee4b8e8c1b05dee73979e72",
"assets/assets/google_fonts/Montserrat-BlackItalic.ttf": "a67f4df02f4d73bb8bfd5bff421e4d1f",
"assets/assets/google_fonts/Newsreader-ExtraLight.ttf": "2449f6d64917a8f4890bac2e54ea439f",
"assets/fonts/MaterialIcons-Regular.otf": "bb8aceb9ac0f327d9be6e3db852eb1dd",
"assets/AssetManifest.bin": "3d3d73bcfeb6c5ee5baeeb0e2c5a8f9f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "721a3c6a6eaea09d16481b9ae9943760",
"assets/AssetManifest.json": "84ee89db4dd468270ecce7ec4b50c62c",
"assets/NOTICES": "5bc1ed306a34d113ee9c3e400942db1a",
"index.html": "d5c426ef72400dc340cb531c3adb998c",
"/": "d5c426ef72400dc340cb531c3adb998c",
"main.dart.js": "d5aa77a4dbe0920c4fb720ad3cb465ed",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "29e20395122d9ba2a6a9dd4bd2a0a03e",
"sqlite3.wasm": "9d4d8aa7522ca11c72eb148d1f23a3df",
"flutter_bootstrap.js": "db39eddbe4d5d5126de25c0705b1af72",
"drift_worker.js": "b1b42d2639a16f676982db426871cdba",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"manifest.json": "cd7438b257d41690d320142f93462c27",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061"};
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
