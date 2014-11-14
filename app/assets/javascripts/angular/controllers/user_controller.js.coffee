DptFoot.controller 'UserCtrl', ['$rootScope', '$scope', '$stateParams', '$filter', 'User', 'FriendShip', ($rootScope, $scope, $stateParams, $filter, User, FriendShip) ->
  $scope.avalaibleFriend = false
  
  User.get { id: $stateParams['userId'] }, (data, status) ->
    $scope.profile = data

    return if $scope.isMyProfile()
    $scope.myProfile = false

    $scope.checkIfMyFriend()


  $scope.sendFriendShipInvitation = () ->
    FriendShip.save { friendship: { sender_id: $rootScope.user.id, receiver_id: $scope.profile.id } }
    , success = (friendship) ->
      $scope.profile.friends.ids.push(friendship.id)
      $scope.avalaibleFriend = false
    , error = (data) ->
      alert data

  $scope.isMyProfile = () ->
    return false if $rootScope.user.id != $scope.profile.id

    $scope.avalaibleFriend = false
    $scope.myProfile = true
    return true


  $scope.checkIfMyFriend = () ->
    friendship = $filter('filter')($scope.profile.friends.ids, (friendId) -> return friendId == $rootScope.user.id)
    $scope.avalaibleFriend = friendship.length < 1

  $scope.responseFriendShip = (friendId, response) ->
    friendShipId = $filter('filter')($scope.profile.friendships, (friendship) -> return friendship.sender_id == friendId)[0].id

    FriendShip.update { friendshipId: friendShipId, friendship: { receiver_id: $rootScope.user.id, state: response } }
    , success = (data) ->
      $scope.profile.friends = data.friends
      $scope.profile.friends.ids = data.friends.ids
    , error = (data) ->
      alert data


    
]
