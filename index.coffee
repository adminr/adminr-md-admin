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
