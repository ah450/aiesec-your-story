# Attempts to retrive a key from local storage
# if not found it issues a get request to the provided url
angular.module 'aiesec'
  .factory 'getOrCache', ($q, $http, localStorageService) ->
    (key, url, rejectValue, unpackWith) ->
      $q (resolve, reject) ->
        value = localStorageService.get(key)
        if value
          resolve(cities)
        else
          success = (response) ->
            if unpackWith
              data = response.data[unpackWith]
            else
              data = response.data[unpackWith]
            localStorageService.set(key, data)
            resolve(data)
          failure = (response) ->
            console.log 'Failed to get ', url
            console.log response
            reject rejectValue
          $http.get(url).then(success, failure)
          return