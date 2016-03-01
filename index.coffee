mod = angular.module('adminr-md-admin',['adminr-md-layout','adminr-md-login','adminr-core','ngMaterial','md.data.table'])


#require('./components/layout.coffee')

mod.config(['AdminrContainerManagerProvider',(AdminrContainerManagerProvider)->
  AdminrContainerManagerProvider.setViewForContainer('adminr-md-layout-top-menu','adminr-md-admin-top-menu')
])

mod.run(['$templateCache',($templateCache)->
  $templateCache.put('adminr-md-admin-top-menu',require('./views/top-menu.html'))
#  $templateCache.put('adminr-md-layout-side-menu',require('./views/side-menu.html'))
])


#mod.provider('AdminrMdLayout',['AdminrContainerManagerProvider','AdminrBasicLayoutProvider',(AdminrContainerManagerProvider,AdminrBasicLayoutProvider)->
#
#  class AdminrMdLayoutStructure
#
#    sidemenu: AdminrBasicLayoutProvider
#
#    brandTitle: null
#
#    setAsRootContainer:()->
#      AdminrContainerManagerProvider.setViewForRootContainer('adminr-md-layout')
##    setAsRootContainerWithLogin:()->
##      AdminrMdLoginProvider.setAsRootContainerView()
##      AdminrMdLoginProvider.setLoggedView('adminr-md-layout')
#    setBrandTitle:(title)->
#      @brandTitle = title
#    $get:()->
#      return @
#
#  return new AdminrMdLayoutStructure()
#])
