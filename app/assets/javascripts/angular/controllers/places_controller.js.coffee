DptFoot.controller 'PlacesCtrl', ['$scope', '$stateParams', 'Department', ($scope, $stateParams, Department) ->

  $scope.loading = true
  
  Department.query { id: $stateParams['departmentId'] }, (places, status) ->
    $scope.places = places
    $scope.loading = false

]
