mod = angular.module('adminr-md-admin',['adminr-md-layout','adminr-md-login','adminr-core','ngMaterial','md.data.table'])


#require('./components/layout.coffee')

mod.config(['AdminrContainerManagerProvider',(AdminrContainerManagerProvider)->
  AdminrContainerManagerProvider.setViewForContainer('adminr-md-layout-top-menu','adminr-md-admin-top-menu')
])

mod.run(['$templateCache',($templateCache)->
  $templateCache.put('adminr-md-admin-top-menu',require('./views/top-menu.html'))
  $templateCache.put('adminr-md-admin-table-toolbar',require('./views/table-toolbar.html'))
])


mod.provider('AdminrMdAdmin',['AdminrMdLoginProvider','AdminrMdLayoutProvider',(AdminrMdLoginProvider,AdminrMdLayoutProvider)->

  class AdminrMdLayoutStructure

    layout: AdminrMdLayoutProvider

    setAsRootContainer:()->
      AdminrMdLoginProvider.setAsRootContainerView()
      AdminrMdLoginProvider.setLoggedView('adminr-md-layout')
    $get:()->
      return @

  return new AdminrMdLayoutStructure()
])


mod.directive('mdAdminTableResource',()->
  return {
    compile:(elm,attrs)->
      resourceName = attrs.mdAdminTableResource
      table = elm.find('table')
      table.attr('md-progress',resourceName + '.$promise')
      table.find('thead').attr('md-order',resourceName + '.params.order')


      bodyRow = table.find('tbody').find('tr').attr('md-order',resourceName + '.params.order')
      if not bodyRow.attr('ng-repeat')
        bodyRow.attr('ng-repeat','row in ' + resourceName + '.data')

      errorBody = angular.element('<tbody class="md-error-body" ng-if="' + resourceName + '.error"><tr><td colspan="50"><span>{{' + resourceName + '.error.data.message || ' + resourceName + '.error.data || ' + resourceName + '.error}}</span></td></tr></tbody>')
      table.append(errorBody)
  }
)

mod.directive('mdAdminResource',['$templateCache','$timeout',($templateCache,$timeout)->
  return {
    scope: yes,
#    scope:{
#      resource:'=mdAdminPaginationResource'
#    },
#    priority: 1
    compile:(elm,attrs)->
      resourceName = attrs.mdAdminResource
      pagingRange = '_pagingResource' + Math.floor(Math.random()*99999)
      pagination = elm.find('md-table-pagination')
      pagination.attr('md-total','{{' + pagingRange + '.count}}')
      pagination.attr('md-limit',pagingRange + '.limit')
      pagination.attr('md-page',pagingRange + '.page')

      toolbar = elm.find('md-toolbar')
      template = $templateCache.get('adminr-md-admin-table-toolbar')
      toolbarContent = angular.element(template)
      searchInput = toolbarContent.find('input')
      mdTableSearchVariable = null
      if attrs.mdTableSearch is 'true'
        mdTableSearchVariable = resourceName + '.params.q'
      else if attrs.mdTableSearch
        mdTableSearchVariable = attrs.mdTableSearch

      if mdTableSearchVariable
        searchInput.attr('ng-model',mdTableSearchVariable)
      toolbar.append(toolbarContent)

      tableContainer = elm.find('md-table-container')
      if not tableContainer.attr('md-admin-table-resource')
        tableContainer.attr('md-admin-table-resource',resourceName)

      return (scope,elm,attrs)->

        scope.tableTitle = scope.$eval(attrs.mdTableTitle)
        scope.search = {
          enabled: !!attrs.mdTableSearch
          active: no
        }

        scope.activateSearch = ()->
          scope.search.active = yes

          $timeout(()->
            searchInput = elm.find('md-toolbar').find('input')
            searchInput.focus()
          ,0)
        scope.deactivateSearch = ()->
          scope.$eval(mdTableSearchVariable + ' = null')
          scope.search.active = no

        scope[pagingRange] = {page:0}
        scope.$watch(resourceName + '.resolved',(resolved)->
          if resolved
            range = scope.$eval(resourceName + '.range')
            scope[pagingRange].limit = range.limit
            scope[pagingRange].page = range.page
            scope[pagingRange].count = range.count
#          else
#            scope[pagingRange] = {}
        )
        scope.$watch(pagingRange,(newValue)->
          if newValue
            resource = scope.$eval(resourceName)
            if resource?.range
              resource.range.limit = newValue.limit
              resource.range.page = newValue.page
        ,yes)

  }
])

#mod.directive('mdTableSearch',()->
#  return {
#    scope:yes
#    compile:(elm,attr)->
#      console.log('!')
#  }
#)