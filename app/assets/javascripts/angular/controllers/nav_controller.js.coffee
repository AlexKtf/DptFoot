DptFoot.controller 'NavCtrl', ['$rootScope', '$scope', '$state', '$location', 'Current', 'User', ($rootScope, $scope, $state, $location, Current, User) ->

  $scope.user = Current.user

  $scope.setPreviousUrl = () ->
    $rootScope.referer = $location.$$path
    $state.go('home')


  $scope.$on 'user:logged_in', (event, user) ->
    $scope.user = user

  $scope.logout = () ->
    User.destroy_session { user: { id: Current.user.id } }, (data) ->
      Current.user = null
      localStorage.removeItem('clientToken')
      localStorage.removeItem('clientId')
      $scope.user = null
      $rootScope.$broadcast 'Current::logout'
]
