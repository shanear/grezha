`import Ember from "ember"`
`import { test, moduleForComponent } from 'ember-qunit'`

moduleForComponent('search-result', 'Search Result Component',
  setup: ->
    @item = Ember.Object.create({
      name: 'Fabio'
      profession: 'male model'
      highlightFields: ['profession']
    })
)

test 'name - when no match', ->
  component = this.subject(
    filterItem: @item,
    filterQuery: 'Steve'
  )
  equal(component.get('name'), 'Fabio',
    'returns filterItem name when no match')


test 'name - when match', ->
  component = this.subject(
    filterItem: @item,
    filterQuery: 'Fab'
  )
  equal(component.get('name'), "<span class='highlight'>Fab</span>io",
    'returns name with appropriate part highlighted')


test 'searchMatch - when match', ->
  component = this.subject(
    filterItem: @item,
    filterQuery: 'male'
  )
  equal(component.get('searchMatch'), "<span class='highlight'>male</span> model",
    'returns highlightable field with appropriate part highlighted')


test 'searchMatch - when no filterQuery', ->
  component = this.subject(
    filterItem: @item,
    filterQuery: ''
  )
  equal(component.get('searchMatch'), null,
    'returns highlightable field with appropriate part highlighted')
