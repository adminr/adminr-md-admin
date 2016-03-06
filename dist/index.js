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
      var bodyRow, errorBody, resourceName, table;
      resourceName = attrs.mdAdminTableResource;
      table = elm.find('table');
      table.attr('md-progress', resourceName + '.$promise');
      table.find('thead').attr('md-order', resourceName + '.params.order');
      bodyRow = table.find('tbody').find('tr').attr('md-order', resourceName + '.params.order');
      if (!bodyRow.attr('ng-repeat')) {
        bodyRow.attr('ng-repeat', 'row in ' + resourceName + '.data');
      }
      errorBody = angular.element('<tbody class="md-error-body" ng-if="' + resourceName + '.error"><tr><td colspan="50"><span>{{' + resourceName + '.error.data.message || ' + resourceName + '.error.data || ' + resourceName + '.error}}</span></td></tr></tbody>');
      return table.append(errorBody);
    }
  };
});

mod.directive('mdAdminResource', function() {
  return {
    compile: function(elm, attrs) {
      var pagination, pagingRange, resourceName, tableContainer;
      resourceName = attrs.mdAdminResource;
      pagingRange = '_pagingResource' + Math.floor(Math.random() * 99999);
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
            if (resource != null ? resource.range : void 0) {
              resource.range.limit = newValue.limit;
              return resource.range.page = newValue.page;
            }
          }
        }, true);
      };
    }
  };
});


},{"./views/top-menu.html":2}],2:[function(require,module,exports){
module.exports = '<md-menu-item>\n    <md-button ng-click="dataSource.logout()">\n        <i class="mdi mdi-logout mdi-24px"></i>\n        Logout\n    </md-button>\n</md-menu-item>';
},{}]},{},[1]);
