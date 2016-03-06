var mod = angular.module('adminr-core-test',['adminr-md-admin']);

mod.config(function(AdminrMdAdminProvider,AdminrMdLoginProvider,AdminrDataSourcesProvider){
    AdminrMdAdminProvider.setAsRootContainer()

    var datasource = AdminrDataSourcesProvider.createDataSource('Test','https://adminr-test-api.herokuapp.com',{supportsRangeHeader:true})
    datasource.addResource('Me','/me')
    datasource.addResource('User','/users/:id',{id:'@id'})
    datasource.addResource('BlahUser','/blah-users/:id',{id:'@id'})
})


mod.config(function(AdminrMdAdminProvider) {
    AdminrMdAdminProvider.layout.brandTitle = 'MdAdmin example'
    AdminrMdAdminProvider.layout.sidemenu.setHomePage('Dashboard', 'dashboard.html').setIcon('view-dashboard')
    AdminrMdAdminProvider.layout.sidemenu.addPage('users', 'Users', {url:'/users', templateUrl:'users.html'}).setIcon('account')
        .addPage('userDetail','User detail',{url:'/users/:id',templateUrl:'user-detail.html'})
    AdminrMdAdminProvider.layout.sidemenu.addPage('tables', 'Tables', {url:'/tables', templateUrl:'tables.html'}).setIcon('view-headline')
})
