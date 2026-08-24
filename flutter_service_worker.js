'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"drift_worker.js": "afac8b57eb80f0846a382f7303929b0f",
"version.json": "0351f2f681def5caba2c2b3553e23b05",
"icons/Icon-192.png": "332bb1bf2cc9c1cb20aa4c0649ff654c",
"icons/Icon-maskable-512.png": "2f29d01214f376bfd797155980d136cc",
"icons/Icon-maskable-192.png": "332bb1bf2cc9c1cb20aa4c0649ff654c",
"icons/Icon-512.png": "2f29d01214f376bfd797155980d136cc",
"index.html": "6058897460d6c039ae26a0dcf0298bed",
"/": "6058897460d6c039ae26a0dcf0298bed",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"favicon.png": "cb39c897b54b010dcf1528ac0291f397",
"sqlite3.wasm": "9839e2a1f55c56501c36b8e8483ee663",
"assets/AssetManifest.json": "ab966cbfba7601c2c84dacbba33abffe",
"assets/AssetManifest.bin.json": "1a8d14c08c961062fa532a19c133d2e2",
"assets/NOTICES": "01f39785055286cb015bf1eaab212b1b",
"assets/fonts/MaterialIcons-Regular.otf": "5e381623c5795a7dc50b6f14b49a6c54",
"assets/FontManifest.json": "b99352905d86e2111bc8e8c53fb08ee6",
"assets/AssetManifest.bin": "41494e6a39386bd4bd199895e38a7706",
"assets/assets/sample-articles.json": "c4e0c8f04a215b89fd72aefa412d2506",
"assets/assets/article.template.html": "7c95375f0de35a4e7cc910e92d43459c",
"assets/assets/www/styles/base.css": "be6c7a43e929ca402a358fb64fc52ad5",
"assets/assets/www/styles/fonts.css": "7ea57b647a323b82c94a1138892461cd",
"assets/assets/www/fonts/source.txt": "e833b564982f257914d431c58bcb58f3",
"assets/assets/www/fonts/Literata-Bold.ttf": "be6a3cf0a997a0ef54c5ee91d979c0e1",
"assets/assets/www/fonts/Literata-ExtraBoldItalic.ttf": "939c681b05f5a5d25b1f7405ea8318bd",
"assets/assets/www/fonts/Literata-Light.ttf": "7be965a6187fc04a61aeb93487804636",
"assets/assets/www/fonts/Newsreader-Italic.ttf": "a27bed043c140204b7d9fa96fd0645f6",
"assets/assets/www/fonts/Newsreader-ExtraLightItalic.ttf": "c88e03395c65b041b7f47d8369ecbcb2",
"assets/assets/www/fonts/Literata-MediumItalic.ttf": "7e009f2aab98a4da6606f9b456d470f3",
"assets/assets/www/fonts/Lato-Bold.ttf": "24b516c266d7341c954cb2918f1c8f38",
"assets/assets/www/fonts/Montserrat-Thin.ttf": "b3638b16904211d1d24d04ce53810c4d",
"assets/assets/www/fonts/Montserrat-Medium.ttf": "bdb7ba651b7bdcda6ce527b3b6705334",
"assets/assets/www/fonts/Newsreader-SemiBold.ttf": "28687ad1caaae75474651cfcdb502b1c",
"assets/assets/www/fonts/Montserrat-Black.ttf": "cce7ff8c1d7999f907b6760fbe75d99d",
"assets/assets/www/fonts/Newsreader-Regular.ttf": "8f95e499462a81a8490b0fb3c37bacb6",
"assets/assets/www/fonts/Newsreader-ExtraLight.ttf": "2449f6d64917a8f4890bac2e54ea439f",
"assets/assets/www/fonts/Montserrat-Bold.ttf": "ed86af2ed5bbaf879e9f2ec2e2eac929",
"assets/assets/www/fonts/Newsreader-ExtraBoldItalic.ttf": "83182a36b1bf0afc7a14103937aec9df",
"assets/assets/www/fonts/Montserrat-LightItalic.ttf": "c54486c33610a1fca147afc18af3034f",
"assets/assets/www/fonts/Literata-BoldItalic.ttf": "cb1451a2b5570f892043a9f24a7b3d4c",
"assets/assets/www/fonts/Montserrat-MediumItalic.ttf": "2ed625fc9f039d801a5aab9b6f9cd8ef",
"assets/assets/www/fonts/Literata-LightItalic.ttf": "db76e1f244efb24e254d3d95bde4515f",
"assets/assets/www/fonts/Literata-SemiBold.ttf": "593d9465156bbf0665015d6f37bf2071",
"assets/assets/www/fonts/Literata-Medium.ttf": "8aec17fc48f5c524d2be8f99c665d6fc",
"assets/assets/www/fonts/Newsreader-SemiBoldItalic.ttf": "db4515c10af798a288f9dcec61a32243",
"assets/assets/www/fonts/Literata-Italic.ttf": "a5b7fb33ac4290b7d13ceb13dcbf4eff",
"assets/assets/www/fonts/Montserrat-BlackItalic.ttf": "a67f4df02f4d73bb8bfd5bff421e4d1f",
"assets/assets/www/fonts/Newsreader-Light.ttf": "1d8468ca33fe47ad9967eaaee5ad1bbb",
"assets/assets/www/fonts/Montserrat-ExtraBold.ttf": "9e07cac927a9b4d955e2138bf6136d6a",
"assets/assets/www/fonts/Montserrat-Italic.ttf": "cc53ad8bb1c801746c831bb7ce493f74",
"assets/assets/www/fonts/Montserrat-SemiBold.ttf": "cc10461cb5e0a6f2621c7179f4d6de17",
"assets/assets/www/fonts/Montserrat-BoldItalic.ttf": "a49032b6a945b021303f16b664f87e6c",
"assets/assets/www/fonts/Montserrat-Light.ttf": "94fbe93542f684134cad1d775947ca92",
"assets/assets/www/fonts/Literata-Regular.ttf": "daa6877e49c61342395940af4ca224ea",
"assets/assets/www/fonts/Montserrat-Regular.ttf": "5e077c15f6e1d334dd4e9be62b28ac75",
"assets/assets/www/fonts/AtkinsonHyperlegible-Italic.ttf": "163da8d6ac918cef1e8ffd56a33849c4",
"assets/assets/www/fonts/Montserrat-ExtraBoldItalic.ttf": "8a4a6844448e210672d54f8b32932ee9",
"assets/assets/www/fonts/Literata-ExtraLight.ttf": "c0f9ca745b2e9343bfc3f0a0c9bc74d4",
"assets/assets/www/fonts/Newsreader-Medium.ttf": "62bf84d7f16c59284e66ad8da41c1179",
"assets/assets/www/fonts/Literata-ExtraBold.ttf": "9fb10cccfee4b8e8c1b05dee73979e72",
"assets/assets/www/fonts/Literata-ExtraLightItalic.ttf": "9e0cd060c0620a279b96c9e963e6ebcf",
"assets/assets/www/fonts/Literata-BlackItalic.ttf": "8e35bbef2bd7cdeb65f4d65198416384",
"assets/assets/www/fonts/Lato-BlackItalic.ttf": "047217f671c9e0849c97d43e26543046",
"assets/assets/www/fonts/Lato-Black.ttf": "d83ab24f5cf2be8b7a9873dd64f6060a",
"assets/assets/www/fonts/Lato-Regular.ttf": "122dd68d69fe9587e062d20d9ff5de2a",
"assets/assets/www/fonts/Lato-LightItalic.ttf": "2404a6da847c878edbc8280745365cba",
"assets/assets/www/fonts/Lato-Italic.ttf": "5d22f337a040ae2857e36e7c5800369b",
"assets/assets/www/fonts/OFL.txt": "351d297640ae0bc1b0e63946897ebeb9",
"assets/assets/www/fonts/Montserrat-ExtraLight.ttf": "a7fe50578d9aa3966c925cb9722db03a",
"assets/assets/www/fonts/Newsreader-LightItalic.ttf": "bc3dfc93ee8516f517b55655ca505958",
"assets/assets/www/fonts/Newsreader-Bold.ttf": "373c4398a5a6aef2c28ba8b3dc1f05d6",
"assets/assets/www/fonts/Newsreader-ExtraBold.ttf": "72f3d4bf097b8b089aeb5661acd91f79",
"assets/assets/www/fonts/Lato-Thin.ttf": "7ab0bc06eecc1b75f8708aba3d3b044a",
"assets/assets/www/fonts/AtkinsonHyperlegible-Bold.ttf": "08fc19673abeac2cafa733008e8662f1",
"assets/assets/www/fonts/Montserrat-ExtraLightItalic.ttf": "9c3e2f21cc8fba26dc3da67e89a9365d",
"assets/assets/www/fonts/Montserrat-ThinItalic.ttf": "ff9c45e92d16324b8964447d12d1f458",
"assets/assets/www/fonts/Montserrat-SemiBoldItalic.ttf": "75c4176c64611f32faf01a5de7631877",
"assets/assets/www/fonts/Lato-BoldItalic.ttf": "acc03ac1e9162f0388c005177d55d762",
"assets/assets/www/fonts/AtkinsonHyperlegible-BoldItalic.ttf": "a18eedb73a9ff74da81c1885bc57b779",
"assets/assets/www/fonts/Newsreader-BoldItalic.ttf": "990574635e3de7dd3f7231883f287010",
"assets/assets/www/fonts/Newsreader-MediumItalic.ttf": "bbe4169beb7c7df29d9e15071f5bb1d2",
"assets/assets/www/fonts/Literata-Black.ttf": "be90196ffd7543c959b61a3cf670f908",
"assets/assets/www/fonts/AtkinsonHyperlegible-Regular.ttf": "28147924c6c58c46f245a75ebf336a53",
"assets/assets/www/fonts/Literata-SemiBoldItalic.ttf": "b076269bd282cd28655da02c1f295c48",
"assets/assets/www/fonts/Lato-Light.ttf": "2bcc211c05fc425a57b2767a4cdcf174",
"assets/assets/www/fonts/Lato-ThinItalic.ttf": "2b26bc77c3f9432c9d4ca4911520294d",
"assets/assets/www/scripts/mermaid/mermaid.min.js": "1665dd47c862e4c11155721da50df819",
"assets/assets/www/scripts/mermaid/init.js": "5b96250e4b8d8b1f21e0fd3440d900e5",
"assets/assets/www/scripts/mermaid/LICENSE.txt": "c06d54b935c5ea2158444a214eebef04",
"assets/assets/www/scripts/scrolling.js": "462ee546cb053e08e2b50a0d4395d2bf",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/accents.js": "12cdfa5ded3fbf73a0efaec0cb3563b9",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/cyrillic-ss.js": "407307e46129c527d5ac10049b140d8b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/double-struck.js": "603df355dc8ded7467b9e92fb0c89a2a",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/phonetics.js": "45d81141bf38dfca920b24df38ce3c4a",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/shapes.js": "65a979f98dc8490fe7137633bf71f528",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/braille-d.js": "7409987f96c2011752f6eab0b7116e4b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/cyrillic.js": "a2e3b79d70515737df55f6b18a2bc233",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/fraktur.js": "0404f37a7f35cdbc607c6a0303431576",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/variants.js": "d70fa70c201dd8804f02ece8ada7082c",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/cherokee.js": "44f9ee2dd678422e36b5de32f430ea99",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/phonetics-ss.js": "ca046dca8c08b3f0d9e37cd4843ce7f4",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/math.js": "77e720678229c94533ffa2b6e0124166",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif.js": "c79b18196a7233f03bfed48b4c7b0ad7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-bi.js": "beb842b7c97ac10dd6c94028127a8564",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-ex.js": "e51796541d1f2de4827b1e7cb2998415",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/hebrew.js": "a065d9fc77d0dd2603aaad39dd167aab",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/monospace.js": "8143cb4c1724e6295257524c6ab63638",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/script.js": "ecf563f385f4cf71720c65d957b8362e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/devanagari.js": "fe87e9f306ea1c105463bbccfe3ca740",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/braille.js": "867c8fe53678961942913d392a3fa52c",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-r.js": "d4e91c7eb4fb3d0a52b16fe1a55e286d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-i.js": "94befc5e928ca1ef08229e7cbea8e375",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/marrows.js": "dd24fc6f9728aa1fdeeed399bf2e9733",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/symbols.js": "d4b1d81d06bbf7007dc030ca1b3cfd20",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/accents-b-i.js": "7cd11eb93a3789fef0ce3221fb3fa4ae",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/monospace-ex.js": "c52425d922427dae2d7fb19040ef7ea8",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/monospace-l.js": "576e128194ea34f8ebb38132c221a162",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/calligraphic.js": "080c4568b0c5bdd6615a0126e574ba63",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/latin-i.js": "bb1aa9c1a1ac7dee13774e64325ff917",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/mshapes.js": "cd757689c0d5e1cc8a2ae1b3369ccf5b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/arrows.js": "d5a166839acc7aef99e0bf5643168a26",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/greek-ss.js": "73d7259dccd0f1cf5745dc8593822369",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/greek.js": "8f90d78eb0d7a85af2ac6c90dceb46a6",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-b.js": "ed1071cbbab54363e11f10eab70f6c1c",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/PUA.js": "5e6d594ff3a7aca5328ea0659bf6c536",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/latin-b.js": "c6c0d6bffda8219bbeb0dd96e47f12ab",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/latin.js": "4b08c636a0dd307ebcea29a39898231c",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/symbols-b-i.js": "db71a4ba36a854fba34637e5416d7398",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/latin-bi.js": "53b1836f762c9097937a1ef5cd22f7f0",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/arabic.js": "1217ab49106b28aeac01e517ad6ace48",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-msh.woff2": "d3543c6bcb79be9912be3aa2b1335f07",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sy.woff2": "ca846e55065685b5bb73195062f778d6",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-abi.woff2": "6f5cd71ee1a818725549ba887786b067",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-chi.woff2": "419618dd8e18a62b4a15b28d104680dc",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-shb.woff2": "42031ee1e6fe262a230f3491b37ce216",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-chbi.woff2": "d1617154d4117f15ed92d24cd2b73bd2",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyssb.woff2": "eafe007645a743f278cdf6e5ff83a45e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s3.woff2": "336ced6133a4fb4dc5bb2003764c8216",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-he.woff2": "b045da7adc325047c4509856525309f5",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-os.woff2": "3792a3762246f6dda4860a0463548fc0",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ch.woff2": "e515b459cdecee3faf1321fc3fe16067",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-fb.woff2": "bbc15a08a8730a1b3b3ee7317015f6e6",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkssbi.woff2": "246be31b80f00081df1690a908f4c972",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-arl.woff2": "6f81d8f265f0c418c64b0c72277f236e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-i.woff2": "45f89366a4cd2331239a4039bc08cf08",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkssi.woff2": "f2e133702bdc6073ddc79c9e51176c72",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phssbi.woff2": "c109f1797a1abf3a89c1240b265b6908",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phss.woff2": "2e92d16c7ad8ad5bc723af01f5a9eefd",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-hei.woff2": "1bbbaa807ff9cad5c9737e5f556b4a60",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-syi.woff2": "62fc4a389c0ea48a8d057d81519aa43e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cb.woff2": "7f6fa7d708e6272765a73e831f1d555d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sslb.woff2": "c166e7edff5efb70f2d45665a88e55ba",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sslib.woff2": "b2db09f04bb1570e7936691bfce19c9e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ar.woff2": "c7d8dcf4f8faf161743c4a43d6bbdc38",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ai.woff2": "2b37f288b0e399b1723792d28f0ebfea",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-n.woff2": "d9c2b9a4c20af56bb1574bce66094958",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ob.woff2": "714031bbc0a0184114ec5b13659bd556",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-m.woff2": "7f97889f6e2edf5f25b3365cdb9240cb",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-b.woff2": "f757e883a9754509041191ca36bc9a40",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ds.woff2": "923e327e1bb96c83b61a19ca7c0a2548",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-vx.woff2": "3f1f1bbd772d14e56b90977ca56d5ad0",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phb.woff2": "5f4af0c275efa45f84973c4daa65452d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-pui.woff2": "6c8630f99432a7246fd5847c48a926d5",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-chb.woff2": "e1d3bf3abc5098245962e12828e32094",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sb.woff2": "21ff3d8248b5b1dbc90d79b13915dd45",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-v.woff2": "e4043a7d59d1eace6801c519c0f7765d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-zero.woff2": "a20abd2c7d8c90c99500304c779c57b9",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cy.woff2": "5f37a35ca52a2f8130f6d7dc7571992f",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sybi.woff2": "7e7118b11f2bc9ab34e230db2f5b32ba",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sslr.woff2": "a2c993d4f415d46f01b6e666d941d33e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-dv.woff2": "2ebd65221ae559b8fb397a3a3b3edb91",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-b-a.woff2": "0ceee7ee1092d20becc2f535914aeeae",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gk.woff2": "f419a4acce9c5c61bd4071b5f0074e81",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-shbi.woff2": "b55f1acddea2d1610b13ebfea717f315",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkb.woff2": "12be6f71eee9cfa295b9fe8800218d4c",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyss.woff2": "93ec7804d727935c394745c1c465eda0",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-bi.woff2": "e4e1733db8d5efd152130d826f54ed3d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sh.woff2": "70f61b112ed89ffc8db3c87d99266eb9",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-u.woff2": "697a1e921ab1559f946f847e158fbe2e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-rb.woff2": "45c09400380e86d81512d6b8ee55a1d6",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s7.woff2": "c19611956d695127302013005480cdf7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phbi.woff2": "fa278f37fb2fa1a8c12f1b1874ab97c7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s5.woff2": "7b0777852b604264ad0c22c3efd90581",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyssi.woff2": "a0462dbba7aba0167f80b759288d78db",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cybi.woff2": "d2f32eb49bc6db37f249bfc410330a79",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-mx.woff2": "4dd35cee6514ec5555aaaf62e399d8ec",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-so.woff2": "f8513e097c2a8b5619c5cda23c242ff8",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssbx.woff2": "b73726db1e1732784a7a22b9174f17d7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-pu.woff2": "e8df4194897267b03dcd167596504b55",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ab.woff2": "376260a5e82a7441a8d23787d65e0705",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gki.woff2": "7762feeaf41fca6aef3a57ae89d47810",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-syb.woff2": "570fb1aea28c421c679ab7ed6e69586a",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-li.woff2": "1e781f5471cb860597125c5bef90f5b5",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s6.woff2": "4033b3b81f9251d2fee59893d5abfe87",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lo.woff2": "9d76eb7850ff76e9183386d0320bf935",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phssb.woff2": "879e83eadc0f16b0d22bcb25a72ee6c0",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ml.woff2": "17d5665fe2433e07039d2d2b2235263d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-u-a.woff2": "d08e0f277a1b039933c2145dbef372bb",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-mi.woff2": "b8d3b811ad620ac6bba0655b75cabed7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssb.woff2": "0fda5acff761c94e4bd44785063f54f1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssbi.woff2": "328b80ef74183139bbcab925186f3e92",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lr.woff2": "d655b64c9ea64b8c730bce629b2e18bd",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s.woff2": "553dff3858468fadb368ef54e3cadab8",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ph.woff2": "bc5b15bde46924d6ad9c39e23a37dee7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-brd.woff2": "1638508ea2e6fdb58415aa970e069f08",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lib.woff2": "ea77aeaf9772f154a58d6ec2c62618c5",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-em.woff2": "421ef02c4b1e384db03d71e72abd888a",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkbi.woff2": "70b2ecd32cb28b6b6653975582062cf1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-brk.woff2": "e82b9751f0540e095402750a6407cf6e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ss.woff2": "a7cf297b5d2d64cb16323288bdd0681b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lb.woff2": "465b129495d503aece416db14ae36fb2",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-shi.woff2": "da8fb290203e22f3959a9aac6c5fb152",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s4.woff2": "29e9b2ec91cc97fd2ca339335a61f939",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssbix.woff2": "8467c5267c367f9f6bd49da76ceaf724",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phi.woff2": "04b48cc6327b853a5ea3471fe0862bc9",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssx.woff2": "a3e47df709bcbc0a54a28bdfec0411f6",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyb.woff2": "291cff0a8a2fc7088cfacb7156c83fa6",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssi.woff2": "763b2a1615cbf35c9d906bdd5e15b97f",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssli.woff2": "49c1305fa792f49e16946ad7a63dc1a8",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkss.woff2": "d2946ca43596274c9f6110a70034c984",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-hebi.woff2": "b5b97bafbf418175434fbb3b18ea94a7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-pubi.woff2": "355e724fdf9c225b5926f80fdba24348",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-f.woff2": "8fb6da540eae790126bdefe413511f36",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyi.woff2": "96de7af5b351aee7f020ebb98d62fb4d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-mar.woff2": "ef4aa2ed8e358101eccf94ec6cff328f",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lt.woff2": "cb36fbda25e9f24d41f3def6c81e6d14",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phssi.woff2": "0cfa85589329a3fa13d02af395ccf4fc",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkssb.woff2": "e07fec5ae8369b396edb7658900f1b42",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-pub.woff2": "07eba919aa0acd40a8d5537d8a2a49d7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-mm.woff2": "bdd17e08fb1129bea10f040d40f25e83",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-heb.woff2": "4ff6c4415f8354586fd4e81d7656c41c",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssix.woff2": "d4c9c612d3686f97ae69193cff44cfb7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyssbi.woff2": "f503578b2ac6ad698a85c5f5aec0913a",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-br.woff2": "3ff4b304cbba928d527cb2539cd05bd0",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-c.woff2": "d6bfd39caf1539e67d404741b053dff7",
"assets/assets/www/scripts/mathjax/LICENSE.txt": "3b83ef96387f14655fc854ddc3c6bd57",
"assets/assets/www/scripts/mathjax/tex-chtml.js": "b5c568c0d2cd46e43d413d7a9ed7d9d7",
"assets/assets/www/scripts/mathjax/config.js": "8d7a8477fee598eeaeb16f1724e0f7dc",
"assets/assets/www/scripts/webkit_init.js": "ec62072eceda1e452d90be42e571af0d",
"assets/assets/www/scripts/highlightjs/styles/default.min.css": "a0e6a195bb37f98b66ac358947fda29a",
"assets/assets/www/scripts/highlightjs/styles/dark.min.css": "cba110bc4151a254e82b4580e3d5f7d9",
"assets/assets/www/scripts/highlightjs/init.js": "ff5c30a71c03b9812da568e6ecf51076",
"assets/assets/www/scripts/highlightjs/LICENSE.txt": "1536cfb4c71fcc69423296231a64c1c4",
"assets/assets/www/scripts/highlightjs/highlight.min.js": "e43d5372b6165de50a5320cd67559be3",
"assets/assets/www/manifest.json": "1655b13cd4c1e7a79617f3bd41767024",
"assets/assets/sample-images/fdroid.png": "9b25d84f1d84f7ea3d9bd00e9b570974",
"assets/assets/sample-images/medium.png": "805a4102f6c634290499392ba330bc16",
"assets/assets/sample-images/wallabag.png": "533be299f5180c87487e6802b0f0b20c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/language_info_plus/assets/localized_names/mi.json": "38dfc856a4b6b29e4f4a7f7a2cb3aaa4",
"assets/packages/language_info_plus/assets/localized_names/fo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/kl.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sv.json": "6bd4efa500189dfad8bbac52c314d29b",
"assets/packages/language_info_plus/assets/localized_names/de.json": "117fa06ef0e59e41e0dceda13bd9a7b8",
"assets/packages/language_info_plus/assets/localized_names/hy.json": "5e7db09d99ed0ae67db0a23ee59a5273",
"assets/packages/language_info_plus/assets/localized_names/af.json": "0053e52793cfb1231195db24a71d9945",
"assets/packages/language_info_plus/assets/localized_names/tn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/rm.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/yo.json": "137986e02ca822be30493caf5bd6206a",
"assets/packages/language_info_plus/assets/localized_names/hu.json": "997b053a509309f2f8f1c7b25d9f0b4b",
"assets/packages/language_info_plus/assets/localized_names/kk.json": "5cf6530b0497ad6c574b9a49b0921235",
"assets/packages/language_info_plus/assets/localized_names/kg.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ie.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/vi.json": "a79ab87efe0c8da2425e52eed41c060d",
"assets/packages/language_info_plus/assets/localized_names/th.json": "fd7e9a702b9bcaae7986a56476fe2919",
"assets/packages/language_info_plus/assets/localized_names/nb.json": "f6196b6f915eab298ab10f9a4e2cad08",
"assets/packages/language_info_plus/assets/localized_names/wo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ee.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/cy.json": "32b15a8cddfc5ee8f1a450b0bc286fd3",
"assets/packages/language_info_plus/assets/localized_names/bs.json": "51a0fc4a05146cb6f87e3743489ea660",
"assets/packages/language_info_plus/assets/localized_names/so.json": "ea22ee9d7ca9ed55dad915c886da6a37",
"assets/packages/language_info_plus/assets/localized_names/bg.json": "9559b06c95cd1c714d8bf112848f4a35",
"assets/packages/language_info_plus/assets/localized_names/id.json": "79ed654d12c8cb9d37d680fa90c638ee",
"assets/packages/language_info_plus/assets/localized_names/jv.json": "edc65de28b58779ad6bdb7153465bf99",
"assets/packages/language_info_plus/assets/localized_names/kn.json": "85d344ed60c0254ca0049d7b44203fe4",
"assets/packages/language_info_plus/assets/localized_names/fr.json": "2eef6df6d7f1cd2cb01b224ced50b82d",
"assets/packages/language_info_plus/assets/localized_names/mt.json": "a82c09a9065b9bc7d29f25e22c0530f0",
"assets/packages/language_info_plus/assets/localized_names/az.json": "05b4aeb3731dbb44268a01b08a7336be",
"assets/packages/language_info_plus/assets/localized_names/my.json": "d1618df3d9730f5e3b4779af6d9df3ab",
"assets/packages/language_info_plus/assets/localized_names/co.json": "dbfec6b23950b91caf95f26c4ebc3779",
"assets/packages/language_info_plus/assets/localized_names/hi.json": "40f4792a53288f5b4b2813cae574710e",
"assets/packages/language_info_plus/assets/localized_names/ru.json": "02ec4703d333295edccb5b1492e789cd",
"assets/packages/language_info_plus/assets/localized_names/bi.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/no.json": "f6196b6f915eab298ab10f9a4e2cad08",
"assets/packages/language_info_plus/assets/localized_names/ca.json": "1b4df0a6950f54f60d2d08a907513051",
"assets/packages/language_info_plus/assets/localized_names/ik.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/la.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/lt.json": "78717053b045fd59536cf8741d90acc2",
"assets/packages/language_info_plus/assets/localized_names/am.json": "a89f508a0fa726a6bed7ae63cbdcb985",
"assets/packages/language_info_plus/assets/localized_names/uk.json": "3fb8b3ed62bc69c16335daf50a46eb83",
"assets/packages/language_info_plus/assets/localized_names/ur.json": "e9bb0a71470e2ee818441126f56fc626",
"assets/packages/language_info_plus/assets/localized_names/ug.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ks.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/mk.json": "013a4184267251d844ad62ad0b3332a4",
"assets/packages/language_info_plus/assets/localized_names/lv.json": "d1172a55762945eb77c8cf006b2a3e7a",
"assets/packages/language_info_plus/assets/localized_names/sk.json": "ab2b257d054c3af44a86b362ae8c961e",
"assets/packages/language_info_plus/assets/localized_names/tr.json": "7d04aa928c6b70ff3634eadfe848fc54",
"assets/packages/language_info_plus/assets/localized_names/nn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/dv.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/dz.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/iu.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/rw.json": "45097757c552961271c9ea83f617be44",
"assets/packages/language_info_plus/assets/localized_names/sd.json": "7a06798e74fd7d9c6cc549e8bb113d15",
"assets/packages/language_info_plus/assets/localized_names/gv.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ht.json": "2cac4ec02d33e884eb9e40e7ad2acb46",
"assets/packages/language_info_plus/assets/localized_names/sm.json": "9a68f4f32f91cb16c54c7d85b407a952",
"assets/packages/language_info_plus/assets/localized_names/ky.json": "5ae7537ab7d63093845bfbc0d913dd29",
"assets/packages/language_info_plus/assets/localized_names/bo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/tw.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/tk.json": "18a6acf3d4c9803a7bdcbe7720a124b2",
"assets/packages/language_info_plus/assets/localized_names/lo.json": "b7a12662446950bd687d653e79c40e0c",
"assets/packages/language_info_plus/assets/localized_names/za.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sl.json": "4ac29056936705caa2c40d754c017c40",
"assets/packages/language_info_plus/assets/localized_names/ha.json": "97c2471d09c90499f552749512c44b32",
"assets/packages/language_info_plus/assets/localized_names/ta.json": "ccd4f50a813cf8d51bd1fc975efcc6fc",
"assets/packages/language_info_plus/assets/localized_names/lg.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/el.json": "fd7fade5c4d0aa02a2695406a62a25c2",
"assets/packages/language_info_plus/assets/localized_names/ko.json": "4cdf03ea261619fe7b2652b8d15fe807",
"assets/packages/language_info_plus/assets/localized_names/ve.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/hr.json": "604ad525fe7a1a2202839341271b5943",
"assets/packages/language_info_plus/assets/localized_names/eu.json": "09fda3236f7a07b238d96ae015844a09",
"assets/packages/language_info_plus/assets/localized_names/ro.json": "f03744e25c547cef96b69724a5c8da4c",
"assets/packages/language_info_plus/assets/localized_names/bh.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/os.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/en.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/si.json": "d5a6f030683d5f23230132dd82ea898c",
"assets/packages/language_info_plus/assets/localized_names/om.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/uz.json": "2638852eecbf7716d0d186c26a98f61a",
"assets/packages/language_info_plus/assets/localized_names/mr.json": "2ae0d72ce4ac260e14ede09ed949d423",
"assets/packages/language_info_plus/assets/localized_names/ts.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/fy.json": "9bf490cf23ab90e2f3b08cb437d6c048",
"assets/packages/language_info_plus/assets/localized_names/ml.json": "dc74f48d8233f9f2a86f06b8faf87a0d",
"assets/packages/language_info_plus/assets/localized_names/ku.json": "74dd73ca8d93f7ff03f08a926a530acc",
"assets/packages/language_info_plus/assets/localized_names/yi.json": "dce9900dfa258f212d8ddb03a161ee74",
"assets/packages/language_info_plus/assets/localized_names/ig.json": "a0661dfb257b19459888a2cd72c20608",
"assets/packages/language_info_plus/assets/localized_names/zu.json": "6c63e3c2c33321a07da6477796d8ead6",
"assets/packages/language_info_plus/assets/localized_names/he.json": "fc7585faf970acae3ddff1b0d141c61f",
"assets/packages/language_info_plus/assets/localized_names/tt.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/aa.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sa.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/na.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/gn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/br.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ti.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sq.json": "81c04331c737edc00f5bd84ae66b7a69",
"assets/packages/language_info_plus/assets/localized_names/sg.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/et.json": "c7fc1dc09f6d88225da85ebdb04dfa13",
"assets/packages/language_info_plus/assets/localized_names/da.json": "01e8ae3fd33827a33f58644fb3f0f322",
"assets/packages/language_info_plus/assets/localized_names/be.json": "1ff6f9eee39cc3d14438fba84ac96acf",
"assets/packages/language_info_plus/assets/localized_names/fa.json": "14cd3f05bbd2f842e79268180108783e",
"assets/packages/language_info_plus/assets/localized_names/sw.json": "c40e7ed246fe05ce738a61acdae4e162",
"assets/packages/language_info_plus/assets/localized_names/ay.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/st.json": "81eebd70d2f2bb2c3a212e259a48df6b",
"assets/packages/language_info_plus/assets/localized_names/fi.json": "2687abf5fa17a67babb910ea0d134225",
"assets/packages/language_info_plus/assets/localized_names/pa.json": "336c2257a5746facbc767bcfa8ec32f5",
"assets/packages/language_info_plus/assets/localized_names/tg.json": "f196b090c9fbc28f5829746b6dd9a4b1",
"assets/packages/language_info_plus/assets/localized_names/tl.json": "890a59a07dcdc79f2a6bc34d7eb061dd",
"assets/packages/language_info_plus/assets/localized_names/rn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/pt.json": "6af2210d012d2bba57b435e399f15242",
"assets/packages/language_info_plus/assets/localized_names/or.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ba.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ab.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/te.json": "9a67e25b67e3b269f25a47bc7b7d1658",
"assets/packages/language_info_plus/assets/localized_names/ka.json": "41bed723c0625a43310f67607335a68a",
"assets/packages/language_info_plus/assets/localized_names/ny.json": "f8cf8634730bddd6b8927e29c79c0472",
"assets/packages/language_info_plus/assets/localized_names/sr.json": "689f5ff06c31ec7e1937fcb0e5ca205a",
"assets/packages/language_info_plus/assets/localized_names/nl.json": "cc38233c48b947cee05c27f8efb14b46",
"assets/packages/language_info_plus/assets/localized_names/xh.json": "02e223c6d1ff16e105c7e198c526563f",
"assets/packages/language_info_plus/assets/localized_names/ga.json": "d848a31eb2322ac451f1f7c681edbba4",
"assets/packages/language_info_plus/assets/localized_names/as.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ms.json": "757c02540eb1b32871d8f000f3a2928e",
"assets/packages/language_info_plus/assets/localized_names/km.json": "e226b826059bf8c08691c71f0925f8a6",
"assets/packages/language_info_plus/assets/localized_names/qu.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/lb.json": "4f39244431f192d6427ffbc2dc3f2316",
"assets/packages/language_info_plus/assets/localized_names/es.json": "171fa26719be68e174cb113eec6bcdbe",
"assets/packages/language_info_plus/assets/localized_names/mn.json": "8e7420b70d498b04ef3d19237229169f",
"assets/packages/language_info_plus/assets/localized_names/gl.json": "63e1f427db842fc17200252538f04ae8",
"assets/packages/language_info_plus/assets/localized_names/eo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/su.json": "9024aad8765eefbf3330835ebf72dc19",
"assets/packages/language_info_plus/assets/localized_names/ps.json": "1ccfabc44e28d160ab08a198a2d3d6ab",
"assets/packages/language_info_plus/assets/localized_names/gd.json": "89e81a9e21de9c021d25945ee313e050",
"assets/packages/language_info_plus/assets/localized_names/cs.json": "a92cc70af07450763b79e113d02c4003",
"assets/packages/language_info_plus/assets/localized_names/ne.json": "2b91632a1e28bc9839563b87ebdd9578",
"assets/packages/language_info_plus/assets/localized_names/ja.json": "f7fbf5270e95f3bfce5e5c0ac66eb4e7",
"assets/packages/language_info_plus/assets/localized_names/ar.json": "5191a9888a7fc5d00b6abf6f70a659d1",
"assets/packages/language_info_plus/assets/localized_names/bn.json": "f0397abfe57c4de558a5d6573cc5d12b",
"assets/packages/language_info_plus/assets/localized_names/pl.json": "378fe062a9240e7411db484f0a84a9f9",
"assets/packages/language_info_plus/assets/localized_names/vo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/to.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/zh.json": "f57f314bf9d1b765e7440afbda9598de",
"assets/packages/language_info_plus/assets/localized_names/oc.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ak.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/is.json": "6d06189719324bed5bceb4d3f18e9c8d",
"assets/packages/language_info_plus/assets/localized_names/it.json": "468f2dc69fbe502135fac9dd444cfda2",
"assets/packages/language_info_plus/assets/localized_names/gu.json": "d7658eb9b90624899b6ce95e74ee3c16",
"assets/packages/language_info_plus/assets/localized_names/fj.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sn.json": "0887093c63966653326eb638fb827cca",
"assets/packages/language_info_plus/assets/localized_names/ss.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/mg.json": "17ce0484695c49b4576fd8c48d9a9cb2",
"assets/packages/language_info_plus/assets/localized_names/ln.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ia.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/any_image_view/assets/images/not_found.png": "5a8b0b5a27fa16489f7d1be89902ec13",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "dfb94d43b1e563843c3fac627da1164c",
"main.dart.js": "0aeac433e2cd27f523dfe1e6d0d2834f",
"flutter_bootstrap.js": "46f782194a83830f45048002a05d3ec5",
"manifest.json": "ead8714d71cf26bd14b0a8e6a69aba29"};
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
