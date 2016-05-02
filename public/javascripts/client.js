var LinkCollection = Backbone.Collection.extend({
  url: "/links"
})

var LinkView = Backbone.View.extend({
  tagName: "div",
  className: "link",
  render: function () {
    var template = $("#clipboard_link").html()
    var compiled = Handlebars.compile(template)
    var html = compiled(this.model.attributes)
    this.$el.html(html)
    return this
  }
})

var LinkCollectionView = Backbone.View.extend({
  tagName:"div",
  className:"links",
  initialize: function(){
    this.collection.on('add', function () {
      var linkView = new LinkView({model:this.collection.last()})
      this.$el.prepend(linkView.render().el)
    }, this);
    this.collection.on('reset', function(){
      this.$el.html("")	
    }, this)
  },
  render: function () {
    this.collection.each(function (text) {
      var linkView = new LinkView({model:text})
      this.$el.append(linkView.render().el)
    },this)
    return this
  }
})


var TextCollection = Backbone.Collection.extend({
  url: "/text"
})

var TextView = Backbone.View.extend({
  tagName: "div",
  className: "link",
  render: function () {
    var template = $("#clipboard_text").html()
    var compiled = Handlebars.compile(template)
    var html = compiled(this.model.attributes)
    this.$el.html(html)
    return this
  }
})

var TextCollectionView = Backbone.View.extend({
  tagName:"div",
  className:"texts",
  initialize: function(){
    this.collection.on('add', function () {
      var textView = new TextView({model:this.collection.last()})
      this.$el.prepend(textView.render().el)
    }, this);
    this.collection.on('reset', function(){
      this.$el.html("")	
    }, this)
  },
  render: function () {
    this.collection.each(function (text) {
      var textView = new TextView({model:text})
      this.$el.append(textView.render().el)
    },this)
    return this
  }
})
