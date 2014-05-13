// Validate dates have a valid owner in the "user" pointer.
Parse.Cloud.beforeSave('UserPhoto', function (request, response) {
    var currentUser = request.user, objectUser = request.object.get('user');

/*    if (!currentUser || !objectUser) {
        response.error('A UserPhoto should have a valid user.');
    } else if (currentUser.id === objectUser.id) { */
        response.success();
/*    } else {
        response.error('Cannot set user on UserPhoto to a user other than the current user.');
    } */
});
