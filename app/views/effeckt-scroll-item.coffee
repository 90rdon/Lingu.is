effecktScrollItem = Ember.View.extend
  templateName: 'effecktScrollItem'

  _offsetHeight: 0
  _offsetTop: 0
  _offsetBottom: 0
  _state: ''

  # didInsertElement: ->
  #   @set('_offsetHeight', @offsetHeight)
  #   @set('_offsetTop', @offsetTop)
  #   @set('_offsetBottom', @_offsetBottom)
  #   @schduleDestroy()
  #   @schduleUpdate()

  # sync: ->
  #   @items = Array::slice.apply(@element.children)
  #   @listHeight = @element.offsetHeight
  #   i = 0
  #   len = @items.length

  #   while i < len
  #     item = @items[i]
  #     item._offsetHeight = item.offsetHeight
  #     item._offsetTop = item.offsetTop
  #     item._offsetBottom = item._offsetTop + item._offsetHeight
  #     item._state = ''
  #     i++
  #   @update true
  #   return

  # schduleUpdate: ->
  #   Ember.run.scheduleOnce('afterRender', @, @update)

  # update: (force) ->
  #   scrollTop = @element.pageYOffset or @element.scrollTop
  #   scrollBottom = (if scrollTop + @listHeight > 0 then @listHeight else @element.offsetHeight)
  #   if scrollTop isnt @lastTop or force
  #     @lastTop = scrollTop
  #     i = 0
  #     len = @items.length

  #     while i < len
  #       item = @items[i]
  #       if item._offsetBottom < scrollTop
  #         if item._state isnt 'past'
  #           item._state = 'past'
  #           item.classList.add 'past'
  #           item.classList.remove 'future'
  #       else if item._offsetTop > scrollBottom
  #         if item._state isnt 'future'
  #           item._state = 'future'
  #           item.classList.add 'future'
  #           item.classList.remove 'past'
  #       else if item._state
  #         item.classList.remove 'past'  if item._state is 'past'
  #         item.classList.remove 'future'  if item._state is 'future'
  #         item._state = ''
  #       i++
  #   return

  # schduleDestroy: ->
  #   Ember.run.scheduleOnce('willDestroyElement', @, @destroy)

  # destroy: ->
  #   clearInterval @syncInterval
  #   j = 0
  #   len = @items.length

  #   while j < len
  #     item = @items[j]
  #     item.classList.remove 'past'
  #     item.classList.remove 'future'
  #     j++
  #   return


`export default effecktScrollItem`