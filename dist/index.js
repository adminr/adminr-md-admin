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

mod.provider('AdminrMdAdmin', [
  'AdminrMdLoginProvider', 'AdminrMdLayoutProvider', function(AdminrMdLoginProvider, AdminrMdLayoutProvider) {
    var AdminrMdLayoutStructure;
    AdminrMdLayoutStructure = (function() {
      function AdminrMdLayoutStructure() {}

      AdminrMdLayoutStructure.prototype.layout = AdminrMdLayoutProvider;

      AdminrMdLayoutStructure.prototype.setAsRootContainer = function() {
        AdminrMdLoginProvider.setAsRootContainerView();
        return AdminrMdLoginProvider.setLoggedView('adminr-md-layout');
      };

      AdminrMdLayoutStructure.prototype.$get = function() {
        return this;
      };

      return AdminrMdLayoutStructure;

    })();
    return new AdminrMdLayoutStructure();
  }
]);

mod.directive('mdAdminTableResource', function() {
  return {
    compile: function(elm, attrs) {
      var resourceName;
      resourceName = attrs.mdAdminTableResource;
      elm.find('table').attr('md-progress', resourceName + '.$promise');
      return elm.find('table').find('thead').attr('md-order', resourceName + '.params.order');
    }
  };
});

mod.directive('mdAdminResource', function() {
  return {
    compile: function(elm, attrs) {
      var pagination, pagingRange, resourceName, tableContainer;
      resourceName = attrs.mdAdminResource;
      pagingRange = '_pagingResource';
      pagination = elm.find('md-table-pagination');
      pagination.attr('md-total', '{{' + pagingRange + '.count}}');
      pagination.attr('md-limit', pagingRange + '.limit');
      pagination.attr('md-page', pagingRange + '.page');
      tableContainer = elm.find('md-table-container');
      if (!tableContainer.attr('md-admin-table-resource')) {
        tableContainer.attr('md-admin-table-resource', resourceName);
      }
      return function(scope, elm) {
        scope[pagingRange] = {
          page: 0
        };
        scope.$watch(resourceName + '.resolved', function(resolved) {
          var range;
          if (resolved) {
            range = scope.$eval(resourceName + '.range');
            scope[pagingRange].limit = range.limit;
            scope[pagingRange].page = range.page;
            return scope[pagingRange].count = range.count;
          }
        });
        return scope.$watch(pagingRange, function(newValue) {
          var resource;
          if (newValue) {
            resource = scope.$eval(resourceName);
            resource.range.limit = newValue.limit;
            return resource.range.page = newValue.page;
          }
        }, true);
      };
    }
  };
});


},{"./views/top-menu.html":2}],2:[function(require,module,exports){
module.exports = '<md-menu-item>\n    <md-button ng-click="dataSource.logout()">\n        <i class="mdi mdi-logout mdi-24px"></i>\n        Logout\n    </md-button>\n</md-menu-item>';
},{}]},{},[1]);
