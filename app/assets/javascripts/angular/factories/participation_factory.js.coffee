DptFoot.factory 'Participation', ['$resource', ($resource) ->

  return $resource '/participations/:participationId.json', { placeId: '@placeId', participationId: '@participationId' },
    update:
      method: 'PUT'

]