@AdminTables = {}

# adminTablesDom = '<"box"<"box-header"<"box-toolbar"<"pull-left"<lf>><"pull-right"p>>><"box-body"t>>'
adminTablesDom = '<"row"<"input-field col s7 m8 l9"f><"col s1 m1 l1 card"><"input-field col s4 m3 l2 show-select"l>>t<"row table-footer"<"col s5 m4 l3"ir><"col s7 m8 l9"p>>'

adminEditButton = {
	# data: '_id'
	title: '&nbsp;'
	tmpl: () -> if Meteor.isClient && Template.adminEditBtn then Template.adminEditBtn else false
	orderable: false
}
adminDelButton = {
	# data: '_id'
	title: '&nbsp;'
	tmpl: () -> if Meteor.isClient && Template.adminDeleteBtn then Template.adminDeleteBtn else false
	orderable: false
}

adminEditDelButtons = [
	adminEditButton,
	adminDelButton
]

defaultColumns = () -> [
  data: '_id',
  title: 'ID'
]


AdminTables.Users = new Tabular.Table
	# Modify selector to allow search by email
	changeSelector: (selector, userId) ->
		$or = selector['$or']
		$or and selector['$or'] = _.map $or, (exp) ->
			if exp.emails?['$regex']?
				emails: $elemMatch: address: exp.emails
			else
				exp
		selector

	name: 'Users'
	collection: Meteor.users
	columns: _.union [
		{
			data: '_id'
			title: 'Admin'
			# TODO: use `tmpl`
			createdCell: (node, cellData, rowData) ->
				$(node).html(Blaze.toHTMLWithData Template.adminUsersIsAdmin, {_id: cellData}, node)
			width: '40px'
		}
		{
			data: 'emails'
			title: 'Email'
			render: (value) ->
				value[0].address
			searchable: true
		}
		{
			data: 'emails'
			title: 'Mail'
			# TODO: use `tmpl`
			createdCell: (node, cellData, rowData) ->
				$(node).html(Blaze.toHTMLWithData Template.adminUsersMailBtn, {emails: cellData}, node)
			width: '40px'
		}
		{ data: 'createdAt', title: 'Joined' }
	], adminEditDelButtons
	dom: adminTablesDom

adminTablePubName = (collection) ->
	"admin_tabular_#{collection}"

adminCreateTables = (collections) ->
	_.each AdminConfig?.collections, (collection, name) ->
		_.defaults collection, {
			showEditColumn: true
			showDelColumn: true
		}

		columns = _.map collection.tableColumns, (column) ->
			if column.template
				createdCell = (node, cellData, rowData) ->
					Blaze.renderWithData(Template[column.template], {value: cellData, doc: rowData}, node)

			data: column.name
			title: column.label
			createdCell: createdCell

		if columns.length == 0
			columns = defaultColumns()

		if collection.showEditColumn
			columns.push(adminEditButton)
		if collection.showDelColumn
			columns.push(adminDelButton)

		AdminTables[name] = new Tabular.Table
			name: name
			collection: adminCollectionObject(name)
			pub: collection.children and adminTablePubName(name)
			sub: collection.sub
			columns: columns
			extraFields: collection.extraFields
			language:
			  paginate:
			    previous: "<"
			    next: ">"
			dom: adminTablesDom

adminPublishTables = (collections) ->
	_.each collections, (collection, name) ->
		if not collection.children then return undefined
		Meteor.publishComposite adminTablePubName(name), (tableName, ids, fields) ->
			check tableName, String
			check ids, Array
			check fields, Match.Optional Object

			@unblock()

			find: ->
				@unblock()
				adminCollectionObject(name).find {_id: {$in: ids}}, {fields: fields}
			children: collection.children

Meteor.startup ->
	adminCreateTables AdminConfig?.collections
	adminPublishTables AdminConfig?.collections if Meteor.isServer
