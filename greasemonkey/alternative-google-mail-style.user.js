// ==UserScript==
// @name        Alternative Google Mail Style
// @namespace   http://hunch.se
// @description Extend Google Mail style
// @include     https://mail.google.com/*
// @include     http://mail.google.com/*
// @include     http://*.gmail.com/*
// @author      Rasmus Andersson (http://hunch.se/)
// ==/UserScript==

(function () {
  var n = document.createElement('link');
  n.type = 'text/css';
  n.rel = 'stylesheet';
  n.href = 'http://hunch.se/style/gmail.css';
  n.media = 'screen';
  n.title = 'dynamicLoadedSheet';
  document.getElementsByTagName("head")[0].appendChild(n);
})();