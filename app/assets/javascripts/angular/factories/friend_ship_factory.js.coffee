DptFoot.factory 'FriendShip', ['$resource', ($resource) ->

  return $resource '/friend_ships/:friendshipId.json', { friendshipId: '@friendshipId' },
    update:
      method: 'PUT'

]