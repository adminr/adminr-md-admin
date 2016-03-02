(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var mod;

mod = angular.module('adminr-md-admin', ['adminr-md-layout', 'adminr-md-login', 'adminr-core', 'ngMaterial', 'md.data.table']);

mod.config([
  'AdminrContainerManagerProvider', function(AdminrContainerManagerProvider) {
    return AdminrContainerManagerProvider.setViewForContainer('adminr-md-layout-top-menu', 'adminr-md-admin-top-menu');
  }
]);

mod.run([
  '$templateCache', function($templateCache) {
    return $templateCache.put('adminr-md-admin-top-menu', require('./views/top-menu.html'));
  }
]);


},{"./views/top-menu.html":2}],2:[function(require,module,exports){
module.exports = '<md-menu-item>\n    <md-button ng-click="dataSource.logout()">\n        <i class="mdi mdi-logout mdi-24px"></i>\n        Logout\n    </md-button>\n</md-menu-item>';
},{}]},{},[1]);
