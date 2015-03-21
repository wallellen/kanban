Kanban.Views.UserProfile = Backbone.View.extend({
  template: JST['users/profile'],

  events: {
    "submit form.change-password": "changePassword"
  },

  initialize: function () {
    var that = this;
  },

  render: function () {
    var that = this;

    var renderedContent = that.template({
      users: that.collection
    });

    that.$el.html(renderedContent);

    return that;
  },

  changePassword: function (event) {
    var that = this;
    event.preventDefault();
    var $form = $(event.target);
    var attrs = $form.serializeJSON();

    $.ajax({
      method: 'POST',
      url: '/api/users/change_password',
      data: attrs
    }).done(function (data) {
      if (data && data['message']) {
        $('.message').text(data['message']);
      } else {
        $('.message').text('Password changed');
        $form[0].reset()
      }
    }).fail(function () {
      $('.message').text('Failed to change password');
    });
  }

});
