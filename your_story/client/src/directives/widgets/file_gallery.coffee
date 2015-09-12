# Directive for multi file upload image preview widget
angular.module 'aiesec'
  .directive 'fileGallery', ->
    directive =
      restrict: 'AE'
      templateUrl: 'widgets/file_gallery.html'
      controller: 'FileGallery'
      scope:
        files: '=galleryFiles'