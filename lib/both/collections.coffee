@AdminCollectionsCount = new Mongo.Collection 'adminCollectionsCount'

@TasksCollection = new Mongo.Collection 'tasks'

TasksCollection.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true
