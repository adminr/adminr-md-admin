var mod = angular.module('adminr-core-test',['adminr-md-admin']);

mod.config(function(AdminrMdLayoutProvider,AdminrMdLoginProvider,AdminrDataSourcesProvider){
    AdminrMdLoginProvider.setAsRootContainerView()

    AdminrMdLoginProvider.setLoggedView('adminr-md-layout')

    var datasource = AdminrDataSourcesProvider.createDataSource('Test','https://adminr-test-api.herokuapp.com',{supportsRangeHeader:true})
    datasource.addResource('Me','/me')
    datasource.addResource('User','/users/:id',{id:'@id'})
})


mod.config(function(AdminrMdLayoutProvider) {
    AdminrMdLayoutProvider.brandTitle = 'MdAdmin example'
    AdminrMdLayoutProvider.sidemenu.setHomePage('Dashboard', 'dashboard.html').setIcon('view-dashboard')
    AdminrMdLayoutProvider.sidemenu.addPage('users', 'Users', {url:'/users', templateUrl:'users.html'}).setIcon('account')
        .addPage('userDetail','User detail',{url:'/users/:id',templateUrl:'user-detail.html'})
})
