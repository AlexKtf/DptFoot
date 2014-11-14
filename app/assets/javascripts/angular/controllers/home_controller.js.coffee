DptFoot.controller 'HomeCtrl', ['Current', '$rootScope', '$scope', '$state', '$location', 'User', (Current, $rootScope, $scope, $state, $location, User) ->

  if Current.user && Current.user.id
    $scope.user = Current.user

  $scope.wantConnect = true

  $scope.connectErrors = {}
  $scope.registerErrors = {}

  $scope.register = (user) ->
    User.register { user: { username: user.username, email: user.email, password: user.password } }
    , success = (data) ->
      $scope.setCurrentUser(data)
      $scope.resetErrors()
      $rootScope.$broadcast 'user:logged_in', data
      $scope.redirectOnLogin() if $rootScope.referer?
    , error = (data) ->
      $scope.registerErrors = data.data

  $scope.login = (user) ->
    User.login { user: { login: user.login, password: user.password } }
    , success = (data) ->
      $scope.setCurrentUser(data)
      $scope.resetErrors()
      $rootScope.$broadcast 'user:logged_in', data
      $scope.redirectOnLogin($rootScope.referer)
    , error = (data) ->
      $scope.loginError = data.data


  $scope.changeWanted = (wanted) ->
    $scope.wantConnect = wanted

  $scope.setCurrentUser = (user) ->
    Current.user = user
    localStorage['clientToken'] = user.authentication_token
    localStorage['clientId'] = user.id

  $scope.resetErrors = () ->
    $scope.loginError = null
    $scope.registerErrors = null


  $scope.redirectOnLogin = (referer) ->
    return $state.go('departments') if !referer?
    $location.url(referer)
    $rootScope.referer = null
]