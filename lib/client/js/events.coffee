Template.AdminLayout.events
	'click .btn-delete': (e,t) ->
		_id = $(e.target).attr('doc')
		if Session.equals 'admin_collection_name', 'Users'
			Session.set 'admin_id', _id
			Session.set 'admin_doc', Meteor.users.findOne(_id)
		else
			Session.set 'admin_id', parseID(_id)
			Session.set 'admin_doc', adminCollectionObject(Session.get('admin_collection_name')).findOne(parseID(_id))

Template.AdminDashboardUsersEdit.events
	'click .btn-add-role': (e,t) ->
		console.log 'adding user'
		Meteor.call 'adminAddUserToRole', $(e.target).attr('user'), $(e.target).attr('role')
	'click .btn-remove-role': (e,t) ->
		console.log 'removing user'
		Meteor.call 'adminRemoveUserToRole', $(e.target).attr('user'), $(e.target).attr('role')

Template.UserMenu.events
	'click .btn-sign-out': () ->
		Meteor.logout ->
			Router.go('/')