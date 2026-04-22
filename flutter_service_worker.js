'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/assets/www/manifest.json": "0d266b633917dff351ef7f94b37d98df",
"assets/assets/www/scripts/scrolling.js": "462ee546cb053e08e2b50a0d4395d2bf",
"assets/assets/www/scripts/mermaid/LICENSE.txt": "c06d54b935c5ea2158444a214eebef04",
"assets/assets/www/scripts/mermaid/init.js": "5b96250e4b8d8b1f21e0fd3440d900e5",
"assets/assets/www/scripts/mermaid/mermaid.min.js": "def493e96e3915c5dd101c4395d72dfa",
"assets/assets/www/scripts/highlightjs/LICENSE.txt": "1536cfb4c71fcc69423296231a64c1c4",
"assets/assets/www/scripts/highlightjs/init.js": "ff5c30a71c03b9812da568e6ecf51076",
"assets/assets/www/scripts/highlightjs/styles/dark.min.css": "cba110bc4151a254e82b4580e3d5f7d9",
"assets/assets/www/scripts/highlightjs/styles/default.min.css": "a0e6a195bb37f98b66ac358947fda29a",
"assets/assets/www/scripts/highlightjs/highlight.min.js": "e43d5372b6165de50a5320cd67559be3",
"assets/assets/www/scripts/mathjax/LICENSE.txt": "3b83ef96387f14655fc854ddc3c6bd57",
"assets/assets/www/scripts/mathjax/config.js": "8d7a8477fee598eeaeb16f1724e0f7dc",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/latin-i.js": "205abd21f66cea6a3fb08ada148df453",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/cyrillic.js": "377c613df00ebebb46c06d652944e60b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/accents-b-i.js": "bea1c86fa4cece3fe3eda9237cf7421e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/phonetics.js": "3944d7e39db6b27f4652007dde1f1ee0",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif.js": "801418c8d532e3ddcec47a6b4cb407db",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/monospace-ex.js": "165d3d910765ccf7e13e8ddc734a92a1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/script.js": "c500a87ffb8c3acfbdd6c916be2e6e32",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-b.js": "814c95ff8acf70001ce19f5c0fe3046f",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/marrows.js": "2e50f445f8a20acf7a084399d67d8720",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/greek.js": "79f610605d33090c71a608aeec289df7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/shapes.js": "f1541de4f110adcf51aedc45b0c233ca",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/greek-ss.js": "f1dd7d37d80f382e97ef7f7b154e2ce1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-r.js": "8e996e664cd3b2387b45e2c6dc9d27ec",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/latin-b.js": "7dd18dac242d16a062680e96e19bcbde",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/braille-d.js": "7fe52842475df844ac8414b1d401ee4b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/symbols.js": "9b2b3d5b3b1328ae8ec58059e1fb179d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/devanagari.js": "3fee0080e708d88292796e540c862095",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/latin-bi.js": "8c970e2ca7b15faf889bcb05f8e140d1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/fraktur.js": "f6783a6f3df946885cb7593af4fb048c",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/mshapes.js": "a9f000e5423ffbdcfb80c4d336724067",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/accents.js": "06ee673e8ef070d06bcff0826c1d8062",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/cyrillic-ss.js": "151fd86cdaebd549018c3f98e2b06fc9",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/cherokee.js": "f5e92821f2847a771e340c4625c7833b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/arabic.js": "693883fe389696ca922d227b0c346c75",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/PUA.js": "1bf8d9b690f9ca31f97202fc602a27c8",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/math.js": "e70f3198f8b5b5dd02a84f5724e3b146",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/symbols-b-i.js": "1b72912d940adaeece74b5413b080c49",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/hebrew.js": "8b03957a8e7c939034c8f2f93d5bc53b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/double-struck.js": "8cf44392ce7982ba42b90758bcf8586b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-i.js": "1d29166c9d7d0e981acca25dd9fc2a41",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/braille.js": "5bdb3de0b030b53deabcdb161271add7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/calligraphic.js": "6bddc0ad8e0a4543d551ef895d962438",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/monospace.js": "5378357d5d21f2e6f47e5c4204c31468",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-ex.js": "03ba4b10bebb48cd4d9bdef97096fa2f",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/variants.js": "3e17ef4f0b4bbdb1e830e6e6d8960e36",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/sans-serif-bi.js": "472a2019d2e690cafc5710651a2940ab",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/monospace-l.js": "6817a9cae6496bfab538245285eddca3",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/latin.js": "0c52a7166b285d92d22eb0375da9c29e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/arrows.js": "302dd9575fa360b90a4ef6e064f61588",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/dynamic/phonetics-ss.js": "a35c31054e41c2ac18b9112c046d89bd",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gk.woff2": "a47df900771213fce20082ee81cf085a",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-v.woff2": "033cdc0c61f8c396073f671352eb3199",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-i.woff2": "9223b1724daf1946e1b65cc00f8656e7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-f.woff2": "67900fdec8ffe8975859757a1e8875fa",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-mar.woff2": "c9e2c84c87e9f0a5f88304d8d9b8dc09",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phi.woff2": "e5d6c1c4050b11f3774146fc7e512463",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lt.woff2": "c7d3d5be3e9bfcd1a5e3f5eea792666e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-m.woff2": "255afc65836df544dd09001afcff70bc",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssli.woff2": "68d5d371b6d11adc348985dee697dc82",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssi.woff2": "d250ff78fdc630668b7ca03cba2df865",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkbi.woff2": "a7b38e8a7e007ffa1636242341d5d521",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ai.woff2": "18a51406529f7d4dfcd2e81f89516d11",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s5.woff2": "ea891658902b0ef4fc33270984e62098",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-msh.woff2": "373a4600ed4b26bf5eefb9be85a2b4c3",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sslr.woff2": "73e5b6df78e4c3ec86c74bfd9388fbfd",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phssbi.woff2": "0013d238d7c3c715fc6c46e2b523e8b7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-pubi.woff2": "7a6cfaf55395db3d080f5ae66143b441",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sslb.woff2": "b028841c2b2e3066a3895e25023cc022",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-pu.woff2": "0d0a368225527276dad901c9e59b0ad7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-chbi.woff2": "c29f4d28e1deb4446468dc45900aad37",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sy.woff2": "08e0dd2169331fa0a34cacd033570242",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ph.woff2": "c4a9f134156bb5267d606aacdd91cb03",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkb.woff2": "07295a20813bc842d8c73b3aded88d2d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s7.woff2": "43e560b2d7fb00d5a2f26c7f504c200f",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkssi.woff2": "7eb571dc7dc350ced7827a163f3d4743",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyss.woff2": "6aa16842078b0173b15b8727114e8c36",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssbx.woff2": "2c0b91a93c1bb1a7ee447f59776697ff",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-fb.woff2": "acb7a60097a740ddd1ca3a0d0384d704",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ss.woff2": "b03cc90f1eba9d6f1ec4dcf7abdf21a6",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-hebi.woff2": "4e35cfe1d37fc9f257747c812c52d2a1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-chi.woff2": "81bdcbecccf4825ee23a455211cc9e59",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lb.woff2": "3ec211d2bbe1b0e73094fdbdc3207f19",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lo.woff2": "b0ddd06243fff40760dc1c511d7048fe",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-so.woff2": "a856b948dc6504c0e8f3cee57f9bf24e",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-zero.woff2": "0df9537ff09873de9dda479e0b861420",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ab.woff2": "7ddf2dfbbe0e8ef81af534208b17ce8d",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-shb.woff2": "259fd710ae65da7116bc5b3759fe77e7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkssb.woff2": "dbf93f9950b073a0a78f3a2d0365e5cc",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-b-a.woff2": "8ec433364584c70297dcef73a696a325",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssx.woff2": "d85f5ae178af300b99a5c8583503f006",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyi.woff2": "25f5c32edc79f45afca883b29e256919",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-bi.woff2": "00b1f5ca29a0a75520c2c8f7abef2428",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ar.woff2": "be477bdce88708a5d2b950455f15bb85",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-mx.woff2": "d7286f62be27632e1e5b5523ed16f329",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-br.woff2": "bc9b97f791f5e4429725bb88c252a759",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cy.woff2": "3922451e03fcd0c1af198727787f01c5",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-brd.woff2": "2ce80420ff993ccdb2c074384f80543b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-hei.woff2": "f4c26bb1608035140825a3dfd497c393",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-syb.woff2": "2df15625a5327583f89fdfb39231a4d6",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-os.woff2": "4dc70bd1c540168cb6223953db5b3381",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-c.woff2": "556ccaa9c2813f4140659acfd8431edf",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cb.woff2": "a2af1753c1e3b6145fc2b9b355ca3509",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ds.woff2": "40f8b23a700adb5b6969a65114714401",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ch.woff2": "d4f0aa586659041e1888b1be6e7bfe73",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-heb.woff2": "f6ba3aa2bfd26078c02b906b416f0fb2",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-mm.woff2": "9a3194d285dc5361d7e2a00d06c66251",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-mi.woff2": "4f8ea306f814aa1b43fd62f9ef783191",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-abi.woff2": "afb7e8baae5cc3331d1ae789c6c638c0",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyssb.woff2": "b3e9f7e40aa10d40c9775c6c1e056116",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-em.woff2": "803ed1e83e08bee751e5bb567e18a294",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phb.woff2": "1d1a25e796b94875a78f308d9843dcf1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-brk.woff2": "736cdc00cb2a0bca86ea970e1cc950af",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssb.woff2": "d8dff310df432db93f44a70d04f7e7c1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cybi.woff2": "a7176e17cdebc8af249b12ba037c6c71",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gki.woff2": "f3b75ea795be46ebd3d1ff9d13e7e2d8",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sb.woff2": "ba5af45dacf8b82575dac5f1eb62104b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sslib.woff2": "ae92139a106ffa43903d8f927d309234",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkssbi.woff2": "1f910c98fb52523f76cf8ce07da84923",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lr.woff2": "2bdf84c8024344c8d96a9e6fd3f43867",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phss.woff2": "7b5575dba4077d60910a8a01ecfcbe1f",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ob.woff2": "27a849acd606df1b9c4cc9d38eed8da2",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s4.woff2": "aacc8c3c4d91646af8aceddfc5142064",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-pub.woff2": "1ca5f73633c3cd88b302179ecbffbc32",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phssb.woff2": "8dd56cb579b4737a1aa3fd8853b55c83",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyb.woff2": "ece5bef41ba682400a0a5033b63bc386",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-b.woff2": "5022d379abb4b384cea4643e94b09e65",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-gkss.woff2": "f07b801aeedc2d78c732283a859cd2ea",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-dv.woff2": "5d3e2fc4ab8f87b5df07f718bd7190df",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-shbi.woff2": "0779dec5e42cf80e21be8e5de5ed9104",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyssi.woff2": "26082bb204da6e09e8112440c3411a30",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sh.woff2": "6856ae2cf2e6bcf763d861b24abce655",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-li.woff2": "a3879bf7db7e425881098ec173392517",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-vx.woff2": "07a1f5bd0cbb94d3006507e5d2ede5e1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-sybi.woff2": "573356a529b1f51b92d6fb25651f1c10",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-shi.woff2": "954bbc47856210d6c89a3f7c19ccf614",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phssi.woff2": "701ed9433e2571872c185d0ed5214279",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-pui.woff2": "230b21ca9490b06ffa1dfec4e5da5dc3",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ml.woff2": "abb504b36040763df00c580c0d18e7f1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-cyssbi.woff2": "0a69b0418efcff0910350d0c97ec4f13",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-he.woff2": "f3c1e8883dc05be0883d24ef7f0d848c",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-phbi.woff2": "268bdc7b9b8b7b0094f6c785d8c6b22a",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-u.woff2": "4d61daac9bd2b08d212a55bd7966e0ca",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-syi.woff2": "c8b4c2745a8dc5171d583d000e6f9ca1",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-arl.woff2": "fe6b43aca3c5f4763377e85393ed97b0",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s3.woff2": "02755d9376341ea05fa0b1c0996a856f",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s6.woff2": "40370e3923c2dee791338f49e7ce7b8b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssbix.woff2": "fee28605154d262e093ddec655fdf51b",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-chb.woff2": "ae98cf79c175ebbd6cffac1f33617fc7",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-lib.woff2": "3e9c0a4776bd576c95cf785e2e4578c2",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-rb.woff2": "12ad3beced1f78b4626932b0caed2099",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-s.woff2": "3f278db07dfd9f4d7644f95285fb8804",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-n.woff2": "947a8152e97e07509a8e45fe8f304f67",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-u-a.woff2": "0df78367b67319a3ec35484d281a79b2",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssbi.woff2": "de3041c830c4bdd7e42dc3ccc6717996",
"assets/assets/www/scripts/mathjax/fonts/mathjax-newcm-font/chtml/woff2/mjx-ncm-ssix.woff2": "008d40d2f4c7474431cdd75167263e19",
"assets/assets/www/scripts/mathjax/tex-chtml.js": "cab4306c205abce253ad5f02da0e6df4",
"assets/assets/www/scripts/webkit_init.js": "ec62072eceda1e452d90be42e571af0d",
"assets/assets/www/styles/fonts.css": "7ea57b647a323b82c94a1138892461cd",
"assets/assets/www/styles/base.css": "be6c7a43e929ca402a358fb64fc52ad5",
"assets/assets/www/fonts/Newsreader-SemiBold.ttf": "28687ad1caaae75474651cfcdb502b1c",
"assets/assets/www/fonts/Literata-ExtraLightItalic.ttf": "9e0cd060c0620a279b96c9e963e6ebcf",
"assets/assets/www/fonts/Montserrat-BlackItalic.ttf": "a67f4df02f4d73bb8bfd5bff421e4d1f",
"assets/assets/www/fonts/Newsreader-ExtraLight.ttf": "2449f6d64917a8f4890bac2e54ea439f",
"assets/assets/www/fonts/Montserrat-Black.ttf": "cce7ff8c1d7999f907b6760fbe75d99d",
"assets/assets/www/fonts/Montserrat-LightItalic.ttf": "c54486c33610a1fca147afc18af3034f",
"assets/assets/www/fonts/Montserrat-SemiBold.ttf": "cc10461cb5e0a6f2621c7179f4d6de17",
"assets/assets/www/fonts/Literata-ExtraBold.ttf": "9fb10cccfee4b8e8c1b05dee73979e72",
"assets/assets/www/fonts/Literata-SemiBold.ttf": "593d9465156bbf0665015d6f37bf2071",
"assets/assets/www/fonts/AtkinsonHyperlegible-Italic.ttf": "163da8d6ac918cef1e8ffd56a33849c4",
"assets/assets/www/fonts/Lato-Bold.ttf": "24b516c266d7341c954cb2918f1c8f38",
"assets/assets/www/fonts/Montserrat-ExtraBold.ttf": "9e07cac927a9b4d955e2138bf6136d6a",
"assets/assets/www/fonts/Lato-Light.ttf": "2bcc211c05fc425a57b2767a4cdcf174",
"assets/assets/www/fonts/Lato-BlackItalic.ttf": "047217f671c9e0849c97d43e26543046",
"assets/assets/www/fonts/AtkinsonHyperlegible-Regular.ttf": "28147924c6c58c46f245a75ebf336a53",
"assets/assets/www/fonts/Newsreader-Medium.ttf": "62bf84d7f16c59284e66ad8da41c1179",
"assets/assets/www/fonts/Literata-BlackItalic.ttf": "8e35bbef2bd7cdeb65f4d65198416384",
"assets/assets/www/fonts/Newsreader-ExtraBold.ttf": "72f3d4bf097b8b089aeb5661acd91f79",
"assets/assets/www/fonts/Montserrat-BoldItalic.ttf": "a49032b6a945b021303f16b664f87e6c",
"assets/assets/www/fonts/Newsreader-Bold.ttf": "373c4398a5a6aef2c28ba8b3dc1f05d6",
"assets/assets/www/fonts/Montserrat-Medium.ttf": "bdb7ba651b7bdcda6ce527b3b6705334",
"assets/assets/www/fonts/Montserrat-ThinItalic.ttf": "ff9c45e92d16324b8964447d12d1f458",
"assets/assets/www/fonts/Literata-LightItalic.ttf": "db76e1f244efb24e254d3d95bde4515f",
"assets/assets/www/fonts/Literata-Light.ttf": "7be965a6187fc04a61aeb93487804636",
"assets/assets/www/fonts/Montserrat-ExtraLightItalic.ttf": "9c3e2f21cc8fba26dc3da67e89a9365d",
"assets/assets/www/fonts/Literata-Bold.ttf": "be6a3cf0a997a0ef54c5ee91d979c0e1",
"assets/assets/www/fonts/Lato-ThinItalic.ttf": "2b26bc77c3f9432c9d4ca4911520294d",
"assets/assets/www/fonts/source.txt": "e833b564982f257914d431c58bcb58f3",
"assets/assets/www/fonts/Montserrat-MediumItalic.ttf": "2ed625fc9f039d801a5aab9b6f9cd8ef",
"assets/assets/www/fonts/Literata-Regular.ttf": "daa6877e49c61342395940af4ca224ea",
"assets/assets/www/fonts/Lato-Black.ttf": "d83ab24f5cf2be8b7a9873dd64f6060a",
"assets/assets/www/fonts/Montserrat-ExtraLight.ttf": "a7fe50578d9aa3966c925cb9722db03a",
"assets/assets/www/fonts/Newsreader-Light.ttf": "1d8468ca33fe47ad9967eaaee5ad1bbb",
"assets/assets/www/fonts/Montserrat-Light.ttf": "94fbe93542f684134cad1d775947ca92",
"assets/assets/www/fonts/Newsreader-ExtraLightItalic.ttf": "c88e03395c65b041b7f47d8369ecbcb2",
"assets/assets/www/fonts/Montserrat-Regular.ttf": "5e077c15f6e1d334dd4e9be62b28ac75",
"assets/assets/www/fonts/Newsreader-ExtraBoldItalic.ttf": "83182a36b1bf0afc7a14103937aec9df",
"assets/assets/www/fonts/Montserrat-ExtraBoldItalic.ttf": "8a4a6844448e210672d54f8b32932ee9",
"assets/assets/www/fonts/Montserrat-SemiBoldItalic.ttf": "75c4176c64611f32faf01a5de7631877",
"assets/assets/www/fonts/OFL.txt": "351d297640ae0bc1b0e63946897ebeb9",
"assets/assets/www/fonts/Lato-Thin.ttf": "7ab0bc06eecc1b75f8708aba3d3b044a",
"assets/assets/www/fonts/Newsreader-LightItalic.ttf": "bc3dfc93ee8516f517b55655ca505958",
"assets/assets/www/fonts/Newsreader-MediumItalic.ttf": "bbe4169beb7c7df29d9e15071f5bb1d2",
"assets/assets/www/fonts/Montserrat-Bold.ttf": "ed86af2ed5bbaf879e9f2ec2e2eac929",
"assets/assets/www/fonts/Literata-ExtraBoldItalic.ttf": "939c681b05f5a5d25b1f7405ea8318bd",
"assets/assets/www/fonts/Literata-ExtraLight.ttf": "c0f9ca745b2e9343bfc3f0a0c9bc74d4",
"assets/assets/www/fonts/Lato-LightItalic.ttf": "2404a6da847c878edbc8280745365cba",
"assets/assets/www/fonts/Montserrat-Italic.ttf": "cc53ad8bb1c801746c831bb7ce493f74",
"assets/assets/www/fonts/AtkinsonHyperlegible-Bold.ttf": "08fc19673abeac2cafa733008e8662f1",
"assets/assets/www/fonts/Lato-BoldItalic.ttf": "acc03ac1e9162f0388c005177d55d762",
"assets/assets/www/fonts/Literata-Black.ttf": "be90196ffd7543c959b61a3cf670f908",
"assets/assets/www/fonts/Literata-MediumItalic.ttf": "7e009f2aab98a4da6606f9b456d470f3",
"assets/assets/www/fonts/AtkinsonHyperlegible-BoldItalic.ttf": "a18eedb73a9ff74da81c1885bc57b779",
"assets/assets/www/fonts/Literata-BoldItalic.ttf": "cb1451a2b5570f892043a9f24a7b3d4c",
"assets/assets/www/fonts/Newsreader-Italic.ttf": "a27bed043c140204b7d9fa96fd0645f6",
"assets/assets/www/fonts/Newsreader-Regular.ttf": "8f95e499462a81a8490b0fb3c37bacb6",
"assets/assets/www/fonts/Lato-Regular.ttf": "122dd68d69fe9587e062d20d9ff5de2a",
"assets/assets/www/fonts/Montserrat-Thin.ttf": "b3638b16904211d1d24d04ce53810c4d",
"assets/assets/www/fonts/Newsreader-SemiBoldItalic.ttf": "db4515c10af798a288f9dcec61a32243",
"assets/assets/www/fonts/Lato-Italic.ttf": "5d22f337a040ae2857e36e7c5800369b",
"assets/assets/www/fonts/Literata-Italic.ttf": "a5b7fb33ac4290b7d13ceb13dcbf4eff",
"assets/assets/www/fonts/Literata-Medium.ttf": "8aec17fc48f5c524d2be8f99c665d6fc",
"assets/assets/www/fonts/Literata-SemiBoldItalic.ttf": "b076269bd282cd28655da02c1f295c48",
"assets/assets/www/fonts/Newsreader-BoldItalic.ttf": "990574635e3de7dd3f7231883f287010",
"assets/assets/article.template.html": "7aa3c0d42f2a7157af1ea1df57907225",
"assets/assets/sample-articles.json": "793c0ee88d8209a25d7d217f23e501e6",
"assets/AssetManifest.json": "5d2a63aa53cb5b22547c2e3830a8463c",
"assets/AssetManifest.bin.json": "c0b727d7747299164b097fd126a3d983",
"assets/packages/language_info_plus/assets/localized_names/th.json": "fd7e9a702b9bcaae7986a56476fe2919",
"assets/packages/language_info_plus/assets/localized_names/fa.json": "14cd3f05bbd2f842e79268180108783e",
"assets/packages/language_info_plus/assets/localized_names/ug.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/bi.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/kl.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ik.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/dv.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ba.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/dz.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sn.json": "0887093c63966653326eb638fb827cca",
"assets/packages/language_info_plus/assets/localized_names/ky.json": "5ae7537ab7d63093845bfbc0d913dd29",
"assets/packages/language_info_plus/assets/localized_names/tn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ak.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/nn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/kk.json": "5cf6530b0497ad6c574b9a49b0921235",
"assets/packages/language_info_plus/assets/localized_names/en.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/gd.json": "89e81a9e21de9c021d25945ee313e050",
"assets/packages/language_info_plus/assets/localized_names/as.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ln.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ne.json": "2b91632a1e28bc9839563b87ebdd9578",
"assets/packages/language_info_plus/assets/localized_names/ja.json": "f7fbf5270e95f3bfce5e5c0ac66eb4e7",
"assets/packages/language_info_plus/assets/localized_names/km.json": "e226b826059bf8c08691c71f0925f8a6",
"assets/packages/language_info_plus/assets/localized_names/ht.json": "2cac4ec02d33e884eb9e40e7ad2acb46",
"assets/packages/language_info_plus/assets/localized_names/so.json": "ea22ee9d7ca9ed55dad915c886da6a37",
"assets/packages/language_info_plus/assets/localized_names/af.json": "0053e52793cfb1231195db24a71d9945",
"assets/packages/language_info_plus/assets/localized_names/gu.json": "d7658eb9b90624899b6ce95e74ee3c16",
"assets/packages/language_info_plus/assets/localized_names/ro.json": "f03744e25c547cef96b69724a5c8da4c",
"assets/packages/language_info_plus/assets/localized_names/hu.json": "997b053a509309f2f8f1c7b25d9f0b4b",
"assets/packages/language_info_plus/assets/localized_names/to.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/kg.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/mi.json": "38dfc856a4b6b29e4f4a7f7a2cb3aaa4",
"assets/packages/language_info_plus/assets/localized_names/hy.json": "5e7db09d99ed0ae67db0a23ee59a5273",
"assets/packages/language_info_plus/assets/localized_names/zu.json": "6c63e3c2c33321a07da6477796d8ead6",
"assets/packages/language_info_plus/assets/localized_names/lo.json": "b7a12662446950bd687d653e79c40e0c",
"assets/packages/language_info_plus/assets/localized_names/uk.json": "3fb8b3ed62bc69c16335daf50a46eb83",
"assets/packages/language_info_plus/assets/localized_names/bg.json": "9559b06c95cd1c714d8bf112848f4a35",
"assets/packages/language_info_plus/assets/localized_names/ay.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/wo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sg.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ca.json": "1b4df0a6950f54f60d2d08a907513051",
"assets/packages/language_info_plus/assets/localized_names/id.json": "79ed654d12c8cb9d37d680fa90c638ee",
"assets/packages/language_info_plus/assets/localized_names/ar.json": "5191a9888a7fc5d00b6abf6f70a659d1",
"assets/packages/language_info_plus/assets/localized_names/gn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/su.json": "9024aad8765eefbf3330835ebf72dc19",
"assets/packages/language_info_plus/assets/localized_names/ur.json": "e9bb0a71470e2ee818441126f56fc626",
"assets/packages/language_info_plus/assets/localized_names/hr.json": "604ad525fe7a1a2202839341271b5943",
"assets/packages/language_info_plus/assets/localized_names/bn.json": "f0397abfe57c4de558a5d6573cc5d12b",
"assets/packages/language_info_plus/assets/localized_names/es.json": "171fa26719be68e174cb113eec6bcdbe",
"assets/packages/language_info_plus/assets/localized_names/la.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ss.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ku.json": "74dd73ca8d93f7ff03f08a926a530acc",
"assets/packages/language_info_plus/assets/localized_names/pa.json": "336c2257a5746facbc767bcfa8ec32f5",
"assets/packages/language_info_plus/assets/localized_names/ig.json": "a0661dfb257b19459888a2cd72c20608",
"assets/packages/language_info_plus/assets/localized_names/pt.json": "6af2210d012d2bba57b435e399f15242",
"assets/packages/language_info_plus/assets/localized_names/mr.json": "2ae0d72ce4ac260e14ede09ed949d423",
"assets/packages/language_info_plus/assets/localized_names/qu.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/mt.json": "a82c09a9065b9bc7d29f25e22c0530f0",
"assets/packages/language_info_plus/assets/localized_names/ms.json": "757c02540eb1b32871d8f000f3a2928e",
"assets/packages/language_info_plus/assets/localized_names/sw.json": "c40e7ed246fe05ce738a61acdae4e162",
"assets/packages/language_info_plus/assets/localized_names/sk.json": "ab2b257d054c3af44a86b362ae8c961e",
"assets/packages/language_info_plus/assets/localized_names/be.json": "1ff6f9eee39cc3d14438fba84ac96acf",
"assets/packages/language_info_plus/assets/localized_names/rw.json": "45097757c552961271c9ea83f617be44",
"assets/packages/language_info_plus/assets/localized_names/tw.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ka.json": "41bed723c0625a43310f67607335a68a",
"assets/packages/language_info_plus/assets/localized_names/sr.json": "689f5ff06c31ec7e1937fcb0e5ca205a",
"assets/packages/language_info_plus/assets/localized_names/za.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/os.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/oc.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/bh.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/te.json": "9a67e25b67e3b269f25a47bc7b7d1658",
"assets/packages/language_info_plus/assets/localized_names/om.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/de.json": "117fa06ef0e59e41e0dceda13bd9a7b8",
"assets/packages/language_info_plus/assets/localized_names/aa.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/my.json": "d1618df3d9730f5e3b4779af6d9df3ab",
"assets/packages/language_info_plus/assets/localized_names/da.json": "01e8ae3fd33827a33f58644fb3f0f322",
"assets/packages/language_info_plus/assets/localized_names/mk.json": "013a4184267251d844ad62ad0b3332a4",
"assets/packages/language_info_plus/assets/localized_names/fi.json": "2687abf5fa17a67babb910ea0d134225",
"assets/packages/language_info_plus/assets/localized_names/ks.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/he.json": "fc7585faf970acae3ddff1b0d141c61f",
"assets/packages/language_info_plus/assets/localized_names/vo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/lg.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/et.json": "c7fc1dc09f6d88225da85ebdb04dfa13",
"assets/packages/language_info_plus/assets/localized_names/hi.json": "40f4792a53288f5b4b2813cae574710e",
"assets/packages/language_info_plus/assets/localized_names/tr.json": "7d04aa928c6b70ff3634eadfe848fc54",
"assets/packages/language_info_plus/assets/localized_names/ab.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/st.json": "81eebd70d2f2bb2c3a212e259a48df6b",
"assets/packages/language_info_plus/assets/localized_names/az.json": "05b4aeb3731dbb44268a01b08a7336be",
"assets/packages/language_info_plus/assets/localized_names/is.json": "6d06189719324bed5bceb4d3f18e9c8d",
"assets/packages/language_info_plus/assets/localized_names/or.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/fy.json": "9bf490cf23ab90e2f3b08cb437d6c048",
"assets/packages/language_info_plus/assets/localized_names/mg.json": "17ce0484695c49b4576fd8c48d9a9cb2",
"assets/packages/language_info_plus/assets/localized_names/lt.json": "78717053b045fd59536cf8741d90acc2",
"assets/packages/language_info_plus/assets/localized_names/nl.json": "cc38233c48b947cee05c27f8efb14b46",
"assets/packages/language_info_plus/assets/localized_names/rm.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/tt.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/eu.json": "09fda3236f7a07b238d96ae015844a09",
"assets/packages/language_info_plus/assets/localized_names/gv.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/fo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/el.json": "fd7fade5c4d0aa02a2695406a62a25c2",
"assets/packages/language_info_plus/assets/localized_names/ny.json": "f8cf8634730bddd6b8927e29c79c0472",
"assets/packages/language_info_plus/assets/localized_names/am.json": "a89f508a0fa726a6bed7ae63cbdcb985",
"assets/packages/language_info_plus/assets/localized_names/lb.json": "4f39244431f192d6427ffbc2dc3f2316",
"assets/packages/language_info_plus/assets/localized_names/gl.json": "63e1f427db842fc17200252538f04ae8",
"assets/packages/language_info_plus/assets/localized_names/cy.json": "32b15a8cddfc5ee8f1a450b0bc286fd3",
"assets/packages/language_info_plus/assets/localized_names/sa.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/xh.json": "02e223c6d1ff16e105c7e198c526563f",
"assets/packages/language_info_plus/assets/localized_names/ie.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/uz.json": "2638852eecbf7716d0d186c26a98f61a",
"assets/packages/language_info_plus/assets/localized_names/tk.json": "18a6acf3d4c9803a7bdcbe7720a124b2",
"assets/packages/language_info_plus/assets/localized_names/yo.json": "137986e02ca822be30493caf5bd6206a",
"assets/packages/language_info_plus/assets/localized_names/ia.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sd.json": "7a06798e74fd7d9c6cc549e8bb113d15",
"assets/packages/language_info_plus/assets/localized_names/ko.json": "4cdf03ea261619fe7b2652b8d15fe807",
"assets/packages/language_info_plus/assets/localized_names/rn.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sl.json": "4ac29056936705caa2c40d754c017c40",
"assets/packages/language_info_plus/assets/localized_names/yi.json": "dce9900dfa258f212d8ddb03a161ee74",
"assets/packages/language_info_plus/assets/localized_names/mn.json": "8e7420b70d498b04ef3d19237229169f",
"assets/packages/language_info_plus/assets/localized_names/ru.json": "02ec4703d333295edccb5b1492e789cd",
"assets/packages/language_info_plus/assets/localized_names/br.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ga.json": "d848a31eb2322ac451f1f7c681edbba4",
"assets/packages/language_info_plus/assets/localized_names/pl.json": "378fe062a9240e7411db484f0a84a9f9",
"assets/packages/language_info_plus/assets/localized_names/it.json": "468f2dc69fbe502135fac9dd444cfda2",
"assets/packages/language_info_plus/assets/localized_names/nb.json": "f6196b6f915eab298ab10f9a4e2cad08",
"assets/packages/language_info_plus/assets/localized_names/iu.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/no.json": "f6196b6f915eab298ab10f9a4e2cad08",
"assets/packages/language_info_plus/assets/localized_names/co.json": "dbfec6b23950b91caf95f26c4ebc3779",
"assets/packages/language_info_plus/assets/localized_names/ps.json": "1ccfabc44e28d160ab08a198a2d3d6ab",
"assets/packages/language_info_plus/assets/localized_names/ti.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/ts.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sm.json": "9a68f4f32f91cb16c54c7d85b407a952",
"assets/packages/language_info_plus/assets/localized_names/fr.json": "2eef6df6d7f1cd2cb01b224ced50b82d",
"assets/packages/language_info_plus/assets/localized_names/tg.json": "f196b090c9fbc28f5829746b6dd9a4b1",
"assets/packages/language_info_plus/assets/localized_names/tl.json": "890a59a07dcdc79f2a6bc34d7eb061dd",
"assets/packages/language_info_plus/assets/localized_names/kn.json": "85d344ed60c0254ca0049d7b44203fe4",
"assets/packages/language_info_plus/assets/localized_names/ta.json": "ccd4f50a813cf8d51bd1fc975efcc6fc",
"assets/packages/language_info_plus/assets/localized_names/na.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/cs.json": "a92cc70af07450763b79e113d02c4003",
"assets/packages/language_info_plus/assets/localized_names/ml.json": "dc74f48d8233f9f2a86f06b8faf87a0d",
"assets/packages/language_info_plus/assets/localized_names/sq.json": "81c04331c737edc00f5bd84ae66b7a69",
"assets/packages/language_info_plus/assets/localized_names/ha.json": "97c2471d09c90499f552749512c44b32",
"assets/packages/language_info_plus/assets/localized_names/fj.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/eo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/sv.json": "6bd4efa500189dfad8bbac52c314d29b",
"assets/packages/language_info_plus/assets/localized_names/lv.json": "d1172a55762945eb77c8cf006b2a3e7a",
"assets/packages/language_info_plus/assets/localized_names/bs.json": "51a0fc4a05146cb6f87e3743489ea660",
"assets/packages/language_info_plus/assets/localized_names/jv.json": "edc65de28b58779ad6bdb7153465bf99",
"assets/packages/language_info_plus/assets/localized_names/ee.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/vi.json": "a79ab87efe0c8da2425e52eed41c060d",
"assets/packages/language_info_plus/assets/localized_names/zh.json": "f57f314bf9d1b765e7440afbda9598de",
"assets/packages/language_info_plus/assets/localized_names/si.json": "d5a6f030683d5f23230132dd82ea898c",
"assets/packages/language_info_plus/assets/localized_names/ve.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/language_info_plus/assets/localized_names/bo.json": "6e8e2e0a66386549ef67a6f4ec7962d9",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/packages/any_image_view/assets/images/not_found.png": "5a8b0b5a27fa16489f7d1be89902ec13",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "a2bb7d886c4563a9ab1943a23c45f5b8",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/fonts/MaterialIcons-Regular.otf": "5c5f5bdf48fb128e758db1d153599de8",
"assets/AssetManifest.bin": "555fe368e7c60c20e9a183bc13a5abbb",
"assets/NOTICES": "d8da8a66fcf8d58f95df22c77a84d0d4",
"assets/FontManifest.json": "b99352905d86e2111bc8e8c53fb08ee6",
"favicon.png": "cb39c897b54b010dcf1528ac0291f397",
"manifest.json": "ead8714d71cf26bd14b0a8e6a69aba29",
"index.html": "6058897460d6c039ae26a0dcf0298bed",
"/": "6058897460d6c039ae26a0dcf0298bed",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"drift_worker.js": "afac8b57eb80f0846a382f7303929b0f",
"flutter_bootstrap.js": "1dd0bf53ca3c861be8d84fdc8b35f424",
"main.dart.js": "e5f8a83a9b49040646d440ce33dcf8fc",
"version.json": "0351f2f681def5caba2c2b3553e23b05",
"icons/Icon-maskable-512.png": "2f29d01214f376bfd797155980d136cc",
"icons/Icon-maskable-192.png": "332bb1bf2cc9c1cb20aa4c0649ff654c",
"icons/Icon-512.png": "2f29d01214f376bfd797155980d136cc",
"icons/Icon-192.png": "332bb1bf2cc9c1cb20aa4c0649ff654c",
"sqlite3.wasm": "9839e2a1f55c56501c36b8e8483ee663"};
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
