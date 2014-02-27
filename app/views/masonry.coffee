masonryView = Ember.View.extend
  didInsertElement: ->
    new AnimOnScroll document.getElementById('container-main'),
      document.getElementById('grid'),
        minDuration: 0.4
        maxDuration: 0.7
        viewportFactor: 0.2

`export default masonryView`