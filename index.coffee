mod = angular.module('adminr-md-admin',['adminr-md-layout','adminr-md-login','adminr-core','ngMaterial','md.data.table'])


#require('./components/layout.coffee')

mod.config(['AdminrContainerManagerProvider',(AdminrContainerManagerProvider)->
  AdminrContainerManagerProvider.setViewForContainer('adminr-md-layout-top-menu','adminr-md-admin-top-menu')
])

mod.run(['$templateCache',($templateCache)->
  $templateCache.put('adminr-md-admin-top-menu',require('./views/top-menu.html'))
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

mod.directive('mdAdminResource',()->
  return {
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

      tableContainer = elm.find('md-table-container')
      if not tableContainer.attr('md-admin-table-resource')
        tableContainer.attr('md-admin-table-resource',resourceName)

      return (scope,elm)->
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
)