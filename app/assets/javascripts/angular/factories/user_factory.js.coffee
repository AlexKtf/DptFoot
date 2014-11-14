DptFoot.factory 'User', ['$resource', ($resource) ->

  return $resource '/users/:id.json', id: '@id',
    update:
      method: 'PUT'
    login:
      method: 'POST'
      url: '/users/sign_in.json'
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
      data:
        user:
          login: '@login'
          password: '@password'
    register:
      method: 'POST'
      url: '/users.json'
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
      data:
        user:
          email: '@email'
          username: '@username'
          password: '@password'
    destroy_session:
      method: 'DELETE'
      url: '/users/sign_out.json'
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
      data:
        user:
          id: '@id'

]