DptFoot.filter 'group', () ->
  (items, groupSize) ->
    groups = []
    inner = []
    i = 0

    while i < items.length
      if i % groupSize == 0
        inner = []
        groups.push inner
      inner.push items[i]
      i++
    groups
