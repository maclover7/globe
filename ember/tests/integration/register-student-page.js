import Ember from 'ember';
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';

var App;

module('Integration - New Student Page', {
  beforeEach: function() {
    App = startApp();
  },
  afterEach: function() {
    Ember.run(App, 'destroy');
  }
});

test('Should display New Student', function(assert) {
  visit('/register/students').then(function() {
    assert.equal(find('h1').text(), 'New Student');
  });
});
