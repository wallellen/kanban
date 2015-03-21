Kanban.Views.UsersIndex = Backbone.View.extend({
  template: JST['users/index'],

  events: {
    "submit form.add_user": "addMemberToBoard"
  },

  initialize: function () {
    var that = this;
    this.board = this.options.board;
  },

  render: function () {
    var that = this;

    var renderedContent = that.template({
      users: that.collection
    });

    that.$el.html(renderedContent);

    return that;
  },

  addMemberToBoard: function (event) {
    var that = this;
    event.preventDefault();
    var $form = $(event.target);
    var attrs = {
      board_id: that.board.id,
      user_email: $form.find('.user_email').val()
    }

    var boardMember = new Kanban.Models.BoardMember();

    boardMember.save(attrs, {
      success: function (data) {
        that.collection.add(data.get('user'));
        that.render();
      }
    });
  }

});
