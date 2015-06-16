Template.AdminDashboardViewWrapper.rendered = ->
	node = @firstNode

	@autorun ->
		data = Template.currentData()

		if data.view then Blaze.remove data.view
		while node.firstChild
			node.removeChild node.firstChild

		data.view = Blaze.renderWithData Template.AdminDashboardView, data, node

Template.AdminDashboardViewWrapper.destroyed = ->
	Blaze.remove @data.view

Template.AdminDashboardView.rendered = ->
	table = @$('.dataTable').DataTable();
	filter = @$('.dataTables_filter')
	length = @$('.dataTables_length')

	filter.html '
    <i class="mdi-action-find-in-page prefix"></i>
    <input id="search" type="search" class="validate">
    <label for="search">Filter</label>
	'

	length.html '
		<select>
			<option value="10">10</option>
			<option value="25">25</option>
			<option value="50">50</option>
			<option value="100">100</option>
		</select>
	'

	filter.find('input').on 'keyup', ->
		table.search(@value).draw()

	length.find('select').on 'change', ->
		table.page.len(parseInt @value).draw()


Template.AdminDashboardView.helpers
	hasDocuments: ->
		AdminCollectionsCount.findOne({collection: Session.get 'admin_collection_name'})?.count > 0

Template.UserMenu.helpers
	toLog: (value) ->
		# console.log 'toLog', value
		JSON.stringify value