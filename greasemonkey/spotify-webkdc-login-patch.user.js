// ==UserScript==
// @name           Spotify webkdc login patch
// @namespace      http://spotify.net
// @description    Various fixes
// @include        https://webkdc-001.spotify.net/login*
// ==/UserScript==

// Enables remembering account
document.getElementsByTagName("FORM")[0].removeAttribute("autocomplete");
