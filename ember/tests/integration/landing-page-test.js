import Ember from 'ember';
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';

var App;

module('Integration - Landing Page', {
  beforeEach: function() {
    App = startApp();
  },
  afterEach: function() {
    Ember.run(App, 'destroy');
  }
});

test('Should welcome user to Globe', function(assert) {
  visit('/').then(function() {
    assert.equal(find('h1.center').text(), 'Welcome to Globe!');
  });
});
