window.DptFoot = angular.module 'DptFoot', ['ngResource', 'ngAnimate', 'templates', 'ui.router']


DptFoot.run ($rootScope, $state, Current, User) ->
  if localStorage['clientToken']? and localStorage['clientId']?
    User.get { id: localStorage['clientId'] }
    , success = (user) ->
      Current.user = user
      $rootScope.$broadcast 'user:logged_in', user
      $state.go('departments') if $state.is('home')
    , error = (data) ->
      console.log data


DptFoot.config ['$httpProvider', '$locationProvider', '$stateProvider', '$urlRouterProvider', ($httpProvider, $locationProvider, $stateProvider, $urlRouterProvider) ->

  $locationProvider.html5Mode(true)

  $urlRouterProvider.otherwise('/')

  $stateProvider
  .state 'home',
    url: '/'
    templateUrl: 'home.html'
    controller: 'HomeCtrl'

  .state 'departments',
    url: '/explore'
    templateUrl: 'departments.html'
    controller: 'DepartmentsCtrl'

  .state 'places',
    url: '/:departmentId/places'
    templateUrl: 'places.html'
    controller: 'PlacesCtrl'

  .state 'place',
    url: '/:departmentId/places/:placeId'
    templateUrl: 'place.html'
    controller: 'PlaceCtrl'

  .state 'user',
    url: '/profiles/:userId'
    templateUrl: 'user.html'
    controller: 'UserCtrl'

  $httpProvider.interceptors.push ($q, $log, $location) ->
    request: (config) ->
      return config if !localStorage['clientToken']?
      config.headers['clientToken'] = localStorage['clientToken']
      config.headers['clientId'] = localStorage['clientId']
      return config

    responseError: (response) ->



]

      