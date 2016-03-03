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
      elm.find('table').attr('md-progress',resourceName + '.$promise')
      elm.find('table').find('thead').attr('md-order',resourceName + '.params.order')
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
      pagingRange = '_pagingResource'
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