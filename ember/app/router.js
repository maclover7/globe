import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('home', { path: '/' });
  // User Authentication
  this.route('auth');
  this.route('register-student', { path: '/register/students' });
  this.route('register-teacher', { path: '/register/teachers' });
  this.route('login');
});

export default Router;
