DptFoot.controller 'NavCtrl', ['$rootScope', '$scope', '$state', '$location', 'User', ($rootScope, $scope, $state, $location, User) ->

  $scope.setPreviousUrl = () ->
    $rootScope.referer = $location.$$path
    $state.go('home')


  $scope.logout = () ->
    User.destroy_session { user: { id: $rootScope.user.id } }, (data) ->
      localStorage.removeItem('clientToken')
      localStorage.removeItem('clientId')
      $rootScope.user = null
]
