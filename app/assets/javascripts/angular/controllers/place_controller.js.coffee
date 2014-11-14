DptFoot.controller 'PlaceCtrl', ['$rootScope', '$scope', '$stateParams', '$filter', 'Place', 'Participation', ($rootScope, $scope, $stateParams, $filter, Place, Participation) ->
  
  $scope.loading = true
  $scope.slickLoading = true

  Place.get { id: $stateParams['placeId'] }, (place, status) ->
    $scope.place = place
    $scope.participations = $filter('group')(place.participations_with_users, 6)

    $scope.loading = false
    return if has_no_participations(place.participations_with_users) or !$rootScope.user?
    
    participation = $filter('filter')(place.participations_with_users, (participation) -> return participation.user.id == $rootScope.user.id)
    $scope.is_participant = participation.length > 0


  $scope.participate = () ->
    Participation.save { participation: { user_id: $rootScope.user.id, place_id: $scope.place.id } }
    , success = (participation) ->
      $scope.is_participant = true
      $scope.place.participations_with_users.push(participation)
      $scope.slickLoading = true
      $scope.participations = $filter('group')($scope.place.participations_with_users, 6)
      $scope.$broadcast 'addSlick'
    , error = (data) ->
      alert data


  has_no_participations = (resource) ->
    if resource.length < 1
      $scope.is_participant = false
      return true
    return false
]
