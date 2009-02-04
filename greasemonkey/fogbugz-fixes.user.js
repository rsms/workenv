// ==UserScript==
// @name           FogBugz fixes
// @namespace      http://www.spotify.com/
// @description    Various FogBugz fixes
// @include        https://*.fogbugz.com/*
// @author         Rasmus Andersson
// @copyright      Copyright (c) 2008 Spotify AB
// ==/UserScript==

(function () {
  // Removes default.asp from ticket links
  var c = document.getElementsByTagName("a");
  for(var i=0; i<c.length; i++) {
    var e = c[i];
    var href = e.getAttribute("href");
    if(href != null && href.substr(0,11) == "default.asp") {
      e.setAttribute("href", "/"+href.substr(11));
    }
  }
})();
