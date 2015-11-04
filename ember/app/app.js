import Ember from 'ember';
import Resolver from 'ember/resolver';
import loadInitializers from 'ember/load-initializers';
import config from './config/environment';

var App;

Ember.MODEL_FACTORY_INJECTIONS = true;

App = Ember.Application.extend({
  modulePrefix: config.modulePrefix,
  podModulePrefix: config.podModulePrefix,
  Resolver: Resolver
});

loadInitializers(App, config.modulePrefix);

Ember.Application.initializer({
  name: 'authentication',
  initialize: function(container, application) {
    // register the Torii authenticator so the session can find them
    container.register('authenticator:torii', App.ToriiAuthenticator);
    Ember.SimpleAuth.setup(container, application);
  }
});

export default App;
