DptFoot.directive 'slick', ['$timeout', ($timeout) ->
  return {
    restrict: 'A'
    link: ($scope, element, attrs) ->
      $timeout ()->
        $(element).slick({infinite: false, slidesToShow: 1, slidesToScroll: 1})
      , 100
      $scope.slickLoading = false

      $scope.$on 'addSlick', () ->
        $(element).unslick()
        $timeout ()->
          $(element).slick({infinite: false, slidesToShow: 1, slidesToScroll: 1})
        , 100
        $scope.slickLoading = false

  }
]
