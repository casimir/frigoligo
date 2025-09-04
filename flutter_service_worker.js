'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"manifest.json": "ead8714d71cf26bd14b0a8e6a69aba29",
"icons/Icon-192.png": "332bb1bf2cc9c1cb20aa4c0649ff654c",
"icons/Icon-maskable-512.png": "2f29d01214f376bfd797155980d136cc",
"icons/Icon-maskable-192.png": "332bb1bf2cc9c1cb20aa4c0649ff654c",
"icons/Icon-512.png": "2f29d01214f376bfd797155980d136cc",
"main.dart.js": "7dcad5d7a9ebb70a7e97f88e20bb90a3",
"version.json": "0351f2f681def5caba2c2b3553e23b05",
"assets/NOTICES": "c0d2f50030ba7929a3d6e96bab60038a",
"assets/fonts/MaterialIcons-Regular.otf": "5bcf5db12aff0de91db9efeee6b8e596",
"assets/AssetManifest.json": "04ffb1ef7a118af812e641be938f5b9f",
"assets/assets/article.template.html": "7aa3c0d42f2a7157af1ea1df57907225",
"assets/assets/google_fonts/Montserrat-ExtraBold.ttf": "9e07cac927a9b4d955e2138bf6136d6a",
"assets/assets/google_fonts/Lato-Light.ttf": "2bcc211c05fc425a57b2767a4cdcf174",
"assets/assets/google_fonts/Lato-Italic.ttf": "5d22f337a040ae2857e36e7c5800369b",
"assets/assets/google_fonts/Literata-Light.ttf": "7be965a6187fc04a61aeb93487804636",
"assets/assets/google_fonts/source.txt": "e833b564982f257914d431c58bcb58f3",
"assets/assets/google_fonts/Newsreader-Light.ttf": "1d8468ca33fe47ad9967eaaee5ad1bbb",
"assets/assets/google_fonts/Newsreader-MediumItalic.ttf": "bbe4169beb7c7df29d9e15071f5bb1d2",
"assets/assets/google_fonts/Montserrat-ExtraLight.ttf": "a7fe50578d9aa3966c925cb9722db03a",
"assets/assets/google_fonts/Literata-ExtraLightItalic.ttf": "9e0cd060c0620a279b96c9e963e6ebcf",
"assets/assets/google_fonts/Montserrat-Light.ttf": "94fbe93542f684134cad1d775947ca92",
"assets/assets/google_fonts/AtkinsonHyperlegible-Italic.ttf": "163da8d6ac918cef1e8ffd56a33849c4",
"assets/assets/google_fonts/Montserrat-Regular.ttf": "5e077c15f6e1d334dd4e9be62b28ac75",
"assets/assets/google_fonts/Literata-LightItalic.ttf": "db76e1f244efb24e254d3d95bde4515f",
"assets/assets/google_fonts/Literata-ExtraBoldItalic.ttf": "939c681b05f5a5d25b1f7405ea8318bd",
"assets/assets/google_fonts/Lato-BoldItalic.ttf": "acc03ac1e9162f0388c005177d55d762",
"assets/assets/google_fonts/Literata-BoldItalic.ttf": "cb1451a2b5570f892043a9f24a7b3d4c",
"assets/assets/google_fonts/Lato-Regular.ttf": "122dd68d69fe9587e062d20d9ff5de2a",
"assets/assets/google_fonts/Montserrat-MediumItalic.ttf": "2ed625fc9f039d801a5aab9b6f9cd8ef",
"assets/assets/google_fonts/Lato-LightItalic.ttf": "2404a6da847c878edbc8280745365cba",
"assets/assets/google_fonts/Literata-Regular.ttf": "daa6877e49c61342395940af4ca224ea",
"assets/assets/google_fonts/Montserrat-Black.ttf": "cce7ff8c1d7999f907b6760fbe75d99d",
"assets/assets/google_fonts/Montserrat-Bold.ttf": "ed86af2ed5bbaf879e9f2ec2e2eac929",
"assets/assets/google_fonts/Newsreader-BoldItalic.ttf": "990574635e3de7dd3f7231883f287010",
"assets/assets/google_fonts/Newsreader-ExtraBold.ttf": "72f3d4bf097b8b089aeb5661acd91f79",
"assets/assets/google_fonts/Lato-Bold.ttf": "24b516c266d7341c954cb2918f1c8f38",
"assets/assets/google_fonts/Montserrat-Italic.ttf": "cc53ad8bb1c801746c831bb7ce493f74",
"assets/assets/google_fonts/Literata-SemiBoldItalic.ttf": "b076269bd282cd28655da02c1f295c48",
"assets/assets/google_fonts/Newsreader-Italic.ttf": "a27bed043c140204b7d9fa96fd0645f6",
"assets/assets/google_fonts/Literata-ExtraLight.ttf": "c0f9ca745b2e9343bfc3f0a0c9bc74d4",
"assets/assets/google_fonts/Montserrat-ThinItalic.ttf": "ff9c45e92d16324b8964447d12d1f458",
"assets/assets/google_fonts/Montserrat-Thin.ttf": "b3638b16904211d1d24d04ce53810c4d",
"assets/assets/google_fonts/Montserrat-SemiBoldItalic.ttf": "75c4176c64611f32faf01a5de7631877",
"assets/assets/google_fonts/AtkinsonHyperlegible-Regular.ttf": "28147924c6c58c46f245a75ebf336a53",
"assets/assets/google_fonts/Lato-Thin.ttf": "7ab0bc06eecc1b75f8708aba3d3b044a",
"assets/assets/google_fonts/Newsreader-SemiBold.ttf": "28687ad1caaae75474651cfcdb502b1c",
"assets/assets/google_fonts/Literata-ExtraBold.ttf": "9fb10cccfee4b8e8c1b05dee73979e72",
"assets/assets/google_fonts/Montserrat-ExtraLightItalic.ttf": "9c3e2f21cc8fba26dc3da67e89a9365d",
"assets/assets/google_fonts/Newsreader-Bold.ttf": "373c4398a5a6aef2c28ba8b3dc1f05d6",
"assets/assets/google_fonts/Lato-BlackItalic.ttf": "047217f671c9e0849c97d43e26543046",
"assets/assets/google_fonts/Montserrat-LightItalic.ttf": "c54486c33610a1fca147afc18af3034f",
"assets/assets/google_fonts/Newsreader-SemiBoldItalic.ttf": "db4515c10af798a288f9dcec61a32243",
"assets/assets/google_fonts/AtkinsonHyperlegible-Bold.ttf": "08fc19673abeac2cafa733008e8662f1",
"assets/assets/google_fonts/Newsreader-ExtraLightItalic.ttf": "c88e03395c65b041b7f47d8369ecbcb2",
"assets/assets/google_fonts/Newsreader-LightItalic.ttf": "bc3dfc93ee8516f517b55655ca505958",
"assets/assets/google_fonts/Montserrat-Medium.ttf": "bdb7ba651b7bdcda6ce527b3b6705334",
"assets/assets/google_fonts/Lato-Black.ttf": "d83ab24f5cf2be8b7a9873dd64f6060a",
"assets/assets/google_fonts/Literata-Italic.ttf": "a5b7fb33ac4290b7d13ceb13dcbf4eff",
"assets/assets/google_fonts/Literata-MediumItalic.ttf": "7e009f2aab98a4da6606f9b456d470f3",
"assets/assets/google_fonts/Montserrat-BoldItalic.ttf": "a49032b6a945b021303f16b664f87e6c",
"assets/assets/google_fonts/Montserrat-ExtraBoldItalic.ttf": "8a4a6844448e210672d54f8b32932ee9",
"assets/assets/google_fonts/Lato-ThinItalic.ttf": "2b26bc77c3f9432c9d4ca4911520294d",
"assets/assets/google_fonts/Literata-Medium.ttf": "8aec17fc48f5c524d2be8f99c665d6fc",
"assets/assets/google_fonts/OFL.txt": "351d297640ae0bc1b0e63946897ebeb9",
"assets/assets/google_fonts/Literata-BlackItalic.ttf": "8e35bbef2bd7cdeb65f4d65198416384",
"assets/assets/google_fonts/Literata-Bold.ttf": "be6a3cf0a997a0ef54c5ee91d979c0e1",
"assets/assets/google_fonts/Newsreader-ExtraBoldItalic.ttf": "83182a36b1bf0afc7a14103937aec9df",
"assets/assets/google_fonts/Newsreader-Medium.ttf": "62bf84d7f16c59284e66ad8da41c1179",
"assets/assets/google_fonts/Newsreader-ExtraLight.ttf": "2449f6d64917a8f4890bac2e54ea439f",
"assets/assets/google_fonts/Literata-Black.ttf": "be90196ffd7543c959b61a3cf670f908",
"assets/assets/google_fonts/AtkinsonHyperlegible-BoldItalic.ttf": "a18eedb73a9ff74da81c1885bc57b779",
"assets/assets/google_fonts/Montserrat-SemiBold.ttf": "cc10461cb5e0a6f2621c7179f4d6de17",
"assets/assets/google_fonts/Newsreader-Regular.ttf": "8f95e499462a81a8490b0fb3c37bacb6",
"assets/assets/google_fonts/Montserrat-BlackItalic.ttf": "a67f4df02f4d73bb8bfd5bff421e4d1f",
"assets/assets/google_fonts/Literata-SemiBold.ttf": "593d9465156bbf0665015d6f37bf2071",
"assets/assets/www/scripts/scrolling.js": "b66182657ecc5d7ecdb9fe452cefb8b1",
"assets/assets/www/styles/fonts.css": "7ea57b647a323b82c94a1138892461cd",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "552f822f4d806936d3a31050f997a9ca",
"assets/AssetManifest.bin": "aca83781a653510b0cba451e552b8538",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "a2bb7d886c4563a9ab1943a23c45f5b8",
"assets/packages/language_info_plus/assets/localized_names/bo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/hy.json": "5e7db09d99ed0ae67db0a23ee59a5273",
"assets/packages/language_info_plus/assets/localized_names/rm.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sl.json": "4ac29056936705caa2c40d754c017c40",
"assets/packages/language_info_plus/assets/localized_names/oc.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/os.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/fr.json": "2eef6df6d7f1cd2cb01b224ced50b82d",
"assets/packages/language_info_plus/assets/localized_names/rw.json": "45097757c552961271c9ea83f617be44",
"assets/packages/language_info_plus/assets/localized_names/ee.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/id.json": "79ed654d12c8cb9d37d680fa90c638ee",
"assets/packages/language_info_plus/assets/localized_names/vo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ak.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ht.json": "2cac4ec02d33e884eb9e40e7ad2acb46",
"assets/packages/language_info_plus/assets/localized_names/jv.json": "edc65de28b58779ad6bdb7153465bf99",
"assets/packages/language_info_plus/assets/localized_names/co.json": "dbfec6b23950b91caf95f26c4ebc3779",
"assets/packages/language_info_plus/assets/localized_names/th.json": "fd7e9a702b9bcaae7986a56476fe2919",
"assets/packages/language_info_plus/assets/localized_names/wo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/tw.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/el.json": "fd7fade5c4d0aa02a2695406a62a25c2",
"assets/packages/language_info_plus/assets/localized_names/ik.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/mr.json": "2ae0d72ce4ac260e14ede09ed949d423",
"assets/packages/language_info_plus/assets/localized_names/na.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/gd.json": "89e81a9e21de9c021d25945ee313e050",
"assets/packages/language_info_plus/assets/localized_names/eo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/km.json": "e226b826059bf8c08691c71f0925f8a6",
"assets/packages/language_info_plus/assets/localized_names/ro.json": "f03744e25c547cef96b69724a5c8da4c",
"assets/packages/language_info_plus/assets/localized_names/fy.json": "9bf490cf23ab90e2f3b08cb437d6c048",
"assets/packages/language_info_plus/assets/localized_names/dv.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/zh.json": "f57f314bf9d1b765e7440afbda9598de",
"assets/packages/language_info_plus/assets/localized_names/ha.json": "97c2471d09c90499f552749512c44b32",
"assets/packages/language_info_plus/assets/localized_names/ca.json": "1b4df0a6950f54f60d2d08a907513051",
"assets/packages/language_info_plus/assets/localized_names/tt.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/gv.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/gn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sd.json": "7a06798e74fd7d9c6cc549e8bb113d15",
"assets/packages/language_info_plus/assets/localized_names/ss.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/pt.json": "6af2210d012d2bba57b435e399f15242",
"assets/packages/language_info_plus/assets/localized_names/tr.json": "7d04aa928c6b70ff3634eadfe848fc54",
"assets/packages/language_info_plus/assets/localized_names/as.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/et.json": "c7fc1dc09f6d88225da85ebdb04dfa13",
"assets/packages/language_info_plus/assets/localized_names/cy.json": "32b15a8cddfc5ee8f1a450b0bc286fd3",
"assets/packages/language_info_plus/assets/localized_names/eu.json": "09fda3236f7a07b238d96ae015844a09",
"assets/packages/language_info_plus/assets/localized_names/he.json": "fc7585faf970acae3ddff1b0d141c61f",
"assets/packages/language_info_plus/assets/localized_names/sq.json": "81c04331c737edc00f5bd84ae66b7a69",
"assets/packages/language_info_plus/assets/localized_names/sr.json": "689f5ff06c31ec7e1937fcb0e5ca205a",
"assets/packages/language_info_plus/assets/localized_names/ti.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ln.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/bn.json": "f0397abfe57c4de558a5d6573cc5d12b",
"assets/packages/language_info_plus/assets/localized_names/am.json": "a89f508a0fa726a6bed7ae63cbdcb985",
"assets/packages/language_info_plus/assets/localized_names/ba.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/tl.json": "890a59a07dcdc79f2a6bc34d7eb061dd",
"assets/packages/language_info_plus/assets/localized_names/hr.json": "604ad525fe7a1a2202839341271b5943",
"assets/packages/language_info_plus/assets/localized_names/yi.json": "dce9900dfa258f212d8ddb03a161ee74",
"assets/packages/language_info_plus/assets/localized_names/yo.json": "137986e02ca822be30493caf5bd6206a",
"assets/packages/language_info_plus/assets/localized_names/bi.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/kl.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ie.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/fj.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/vi.json": "a79ab87efe0c8da2425e52eed41c060d",
"assets/packages/language_info_plus/assets/localized_names/sw.json": "c40e7ed246fe05ce738a61acdae4e162",
"assets/packages/language_info_plus/assets/localized_names/kk.json": "5cf6530b0497ad6c574b9a49b0921235",
"assets/packages/language_info_plus/assets/localized_names/uk.json": "3fb8b3ed62bc69c16335daf50a46eb83",
"assets/packages/language_info_plus/assets/localized_names/is.json": "6d06189719324bed5bceb4d3f18e9c8d",
"assets/packages/language_info_plus/assets/localized_names/sn.json": "0887093c63966653326eb638fb827cca",
"assets/packages/language_info_plus/assets/localized_names/lv.json": "d1172a55762945eb77c8cf006b2a3e7a",
"assets/packages/language_info_plus/assets/localized_names/si.json": "d5a6f030683d5f23230132dd82ea898c",
"assets/packages/language_info_plus/assets/localized_names/ar.json": "5191a9888a7fc5d00b6abf6f70a659d1",
"assets/packages/language_info_plus/assets/localized_names/ks.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/la.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/gu.json": "d7658eb9b90624899b6ce95e74ee3c16",
"assets/packages/language_info_plus/assets/localized_names/sm.json": "9a68f4f32f91cb16c54c7d85b407a952",
"assets/packages/language_info_plus/assets/localized_names/te.json": "9a67e25b67e3b269f25a47bc7b7d1658",
"assets/packages/language_info_plus/assets/localized_names/ja.json": "f7fbf5270e95f3bfce5e5c0ac66eb4e7",
"assets/packages/language_info_plus/assets/localized_names/za.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ga.json": "d848a31eb2322ac451f1f7c681edbba4",
"assets/packages/language_info_plus/assets/localized_names/lb.json": "4f39244431f192d6427ffbc2dc3f2316",
"assets/packages/language_info_plus/assets/localized_names/en.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/su.json": "9024aad8765eefbf3330835ebf72dc19",
"assets/packages/language_info_plus/assets/localized_names/bs.json": "51a0fc4a05146cb6f87e3743489ea660",
"assets/packages/language_info_plus/assets/localized_names/ml.json": "dc74f48d8233f9f2a86f06b8faf87a0d",
"assets/packages/language_info_plus/assets/localized_names/br.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/lg.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/pl.json": "378fe062a9240e7411db484f0a84a9f9",
"assets/packages/language_info_plus/assets/localized_names/kg.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/de.json": "117fa06ef0e59e41e0dceda13bd9a7b8",
"assets/packages/language_info_plus/assets/localized_names/sv.json": "6bd4efa500189dfad8bbac52c314d29b",
"assets/packages/language_info_plus/assets/localized_names/cs.json": "a92cc70af07450763b79e113d02c4003",
"assets/packages/language_info_plus/assets/localized_names/ta.json": "ccd4f50a813cf8d51bd1fc975efcc6fc",
"assets/packages/language_info_plus/assets/localized_names/hi.json": "40f4792a53288f5b4b2813cae574710e",
"assets/packages/language_info_plus/assets/localized_names/ka.json": "41bed723c0625a43310f67607335a68a",
"assets/packages/language_info_plus/assets/localized_names/sk.json": "ab2b257d054c3af44a86b362ae8c961e",
"assets/packages/language_info_plus/assets/localized_names/aa.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/mi.json": "38dfc856a4b6b29e4f4a7f7a2cb3aaa4",
"assets/packages/language_info_plus/assets/localized_names/nl.json": "cc38233c48b947cee05c27f8efb14b46",
"assets/packages/language_info_plus/assets/localized_names/iu.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ts.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/om.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/st.json": "81eebd70d2f2bb2c3a212e259a48df6b",
"assets/packages/language_info_plus/assets/localized_names/xh.json": "02e223c6d1ff16e105c7e198c526563f",
"assets/packages/language_info_plus/assets/localized_names/ia.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/tk.json": "18a6acf3d4c9803a7bdcbe7720a124b2",
"assets/packages/language_info_plus/assets/localized_names/ne.json": "2b91632a1e28bc9839563b87ebdd9578",
"assets/packages/language_info_plus/assets/localized_names/sa.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/tg.json": "f196b090c9fbc28f5829746b6dd9a4b1",
"assets/packages/language_info_plus/assets/localized_names/mg.json": "17ce0484695c49b4576fd8c48d9a9cb2",
"assets/packages/language_info_plus/assets/localized_names/ru.json": "02ec4703d333295edccb5b1492e789cd",
"assets/packages/language_info_plus/assets/localized_names/ug.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/fo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/bg.json": "9559b06c95cd1c714d8bf112848f4a35",
"assets/packages/language_info_plus/assets/localized_names/to.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/so.json": "ea22ee9d7ca9ed55dad915c886da6a37",
"assets/packages/language_info_plus/assets/localized_names/ab.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ko.json": "4cdf03ea261619fe7b2652b8d15fe807",
"assets/packages/language_info_plus/assets/localized_names/es.json": "171fa26719be68e174cb113eec6bcdbe",
"assets/packages/language_info_plus/assets/localized_names/tn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/or.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ps.json": "1ccfabc44e28d160ab08a198a2d3d6ab",
"assets/packages/language_info_plus/assets/localized_names/zu.json": "6c63e3c2c33321a07da6477796d8ead6",
"assets/packages/language_info_plus/assets/localized_names/ur.json": "e9bb0a71470e2ee818441126f56fc626",
"assets/packages/language_info_plus/assets/localized_names/pa.json": "336c2257a5746facbc767bcfa8ec32f5",
"assets/packages/language_info_plus/assets/localized_names/af.json": "0053e52793cfb1231195db24a71d9945",
"assets/packages/language_info_plus/assets/localized_names/no.json": "f6196b6f915eab298ab10f9a4e2cad08",
"assets/packages/language_info_plus/assets/localized_names/mt.json": "a82c09a9065b9bc7d29f25e22c0530f0",
"assets/packages/language_info_plus/assets/localized_names/dz.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ny.json": "f8cf8634730bddd6b8927e29c79c0472",
"assets/packages/language_info_plus/assets/localized_names/uz.json": "2638852eecbf7716d0d186c26a98f61a",
"assets/packages/language_info_plus/assets/localized_names/my.json": "d1618df3d9730f5e3b4779af6d9df3ab",
"assets/packages/language_info_plus/assets/localized_names/sg.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/qu.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/mk.json": "013a4184267251d844ad62ad0b3332a4",
"assets/packages/language_info_plus/assets/localized_names/nb.json": "f6196b6f915eab298ab10f9a4e2cad08",
"assets/packages/language_info_plus/assets/localized_names/fa.json": "14cd3f05bbd2f842e79268180108783e",
"assets/packages/language_info_plus/assets/localized_names/be.json": "1ff6f9eee39cc3d14438fba84ac96acf",
"assets/packages/language_info_plus/assets/localized_names/kn.json": "85d344ed60c0254ca0049d7b44203fe4",
"assets/packages/language_info_plus/assets/localized_names/ig.json": "a0661dfb257b19459888a2cd72c20608",
"assets/packages/language_info_plus/assets/localized_names/ms.json": "757c02540eb1b32871d8f000f3a2928e",
"assets/packages/language_info_plus/assets/localized_names/bh.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ay.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/lo.json": "b7a12662446950bd687d653e79c40e0c",
"assets/packages/language_info_plus/assets/localized_names/ku.json": "74dd73ca8d93f7ff03f08a926a530acc",
"assets/packages/language_info_plus/assets/localized_names/nn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/hu.json": "997b053a509309f2f8f1c7b25d9f0b4b",
"assets/packages/language_info_plus/assets/localized_names/it.json": "468f2dc69fbe502135fac9dd444cfda2",
"assets/packages/language_info_plus/assets/localized_names/mn.json": "8e7420b70d498b04ef3d19237229169f",
"assets/packages/language_info_plus/assets/localized_names/rn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/da.json": "01e8ae3fd33827a33f58644fb3f0f322",
"assets/packages/language_info_plus/assets/localized_names/fi.json": "2687abf5fa17a67babb910ea0d134225",
"assets/packages/language_info_plus/assets/localized_names/ky.json": "5ae7537ab7d63093845bfbc0d913dd29",
"assets/packages/language_info_plus/assets/localized_names/az.json": "05b4aeb3731dbb44268a01b08a7336be",
"assets/packages/language_info_plus/assets/localized_names/lt.json": "78717053b045fd59536cf8741d90acc2",
"assets/packages/language_info_plus/assets/localized_names/ve.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/gl.json": "63e1f427db842fc17200252538f04ae8",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"flutter_bootstrap.js": "5468bd257cc7e22b8f65af21ad4c4757",
"drift_worker.js": "ae1f716f0e8e90b0a566f82c6ffa3bc2",
"sqlite3.wasm": "19f93db1ac9fb159284ad0a80bfa86f8",
"favicon.png": "cb39c897b54b010dcf1528ac0291f397",
"index.html": "6058897460d6c039ae26a0dcf0298bed",
"/": "6058897460d6c039ae26a0dcf0298bed"};
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
