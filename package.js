Package.describe({
  name: "miniwe-yogiben-admin",
  summary: "A complete admin dashboard solution. Materialized",
  version: "1.2.1",
  git: "https://github.com/miniwe/meteor-admin"
});

Package.on_use(function(api){

  both = ['client','server'];

  api.versionsFrom('METEOR@1.0');

  api.use(
    ['iron:router@1.0.9',
    'coffeescript',
    'underscore',
    'aldeed:collection2@2.3.3',
    'aldeed:autoform',
    'aldeed:template-extension@3.4.3',
    'alanning:roles@1.2.13',
    'raix:handlebar-helpers@0.2.4',
    'reywood:publish-composite@1.3.6',
    'momentjs:moment@2.10.3',
    'aldeed:tabular@1.2.0',
    'meteorhacks:unblock@1.1.0'
    ],
    both);

  api.use(['stylus','session','jquery','templating'],'client');

  api.use(['email'],'server');

  api.add_files([
    'lib/both/AdminDashboard.coffee',
    'lib/both/router.coffee',
    'lib/both/utils.coffee',
    'lib/both/startup.coffee',
    'lib/both/collections.coffee'
    ], both);

  api.add_files([
    'lib/client/html/admin_templates.html',
    'lib/client/html/admin_scheduler.html',
    'lib/client/html/admin_widgets.html',
    'lib/client/html/admin_layouts.html',
    'lib/client/html/admin_sidebar.html',
    'lib/client/html/admin_header.html',
    'lib/client/css/palette.styl',
    'lib/client/css/admin-materialize.styl',
    'lib/client/js/admin_layout.coffee',
    'lib/client/js/helpers.coffee',
    'lib/client/js/templates.coffee',
    'lib/client/js/events.coffee',
    'lib/client/js/autoForm.coffee'
    ], 'client');

  api.add_files([
    'lib/server/publish.coffee',
    'lib/server/methods.coffee'
    ], 'server');



  api.export('AdminDashboard',both);

});
