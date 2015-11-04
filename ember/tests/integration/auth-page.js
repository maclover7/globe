import Ember from 'ember';
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';

var App;

module('Integration - Auth Page', {
  beforeEach: function() {
    App = startApp();
  },
  afterEach: function() {
    Ember.run(App, 'destroy');
  }
});

test('Should display options', function(assert) {
  visit('/auth').then(function() {
    assert.equal(find('h1.center').text(), 'Globe Authentication');
  });
});
