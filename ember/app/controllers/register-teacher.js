import Ember from 'ember';

export default Ember.Controller.extend({
  reset: function(){
    this.setProperties({
      name: "",
      email: "",
      password: ""
    });
  },

  actions: {
    teacherRegister: function(){
      var self = this;
      var data = {
        'user': {
          name: this.get('name'),
          email: this.get('email'),
          password: this.get('password'),
          type: 'Teacher'
        }
      };
      Ember.$.ajax('api/teachers', {
        type: "POST",
        dataType: "JSON",
        data: data,
        "success": function (data) {
          self.set('token', data.authentication_token);
          self.set('student', false);
          self.set('teacher', true);
          alert('Success!');
          self.transitionToRoute('home');
        },
        "error": function () {
          alert('Error! Please try again.');
        }
      });
    }
  }
});

//var post = store.createRecord('post', {
  //title: 'Rails is Omakase',
  //body: 'Lorem ipsum'
//});

//post.save(); // => POST to '/posts'
