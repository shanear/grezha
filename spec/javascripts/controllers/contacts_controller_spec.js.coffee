
describe 'App.ContactsController', ->

  beforeEach ->
    @controller = App.ContactsController.create()
    @store = App.__container__.lookup('store:main')

    Ember.run =>
      @controller.set('model',
        [@store.createRecord('contact', {
          name: "badazz seansie"
        }),
        @store.createRecord('contact', {
          name: "rocky racooon"
          }),
        @store.createRecord('contact', {
          name: "the chosen one"
          })])

  describe 'filteredCollection', ->

    it 'filters names with filterQuery', ->
      @controller.set('filterQuery', "seansie")
      contacts = @controller.get('filteredCollection')

      expect(contacts[0].get('name') == "badazz seansie").toBeTruthy()

    it 'filterQuery is not case sensitive', ->
      @controller.set('filterQuery', "Seansie")
      contacts = @controller.get('filteredCollection')

      expect(contacts[0].get('name') == "badazz seansie").toBeTruthy()

  describe 'newModelText', ->

    it 'should not be undefined', ->
      expect(typeof(@controller.get('newModelText')) == 'undefined').toBeFalsy()

    it 'is "Contact" when filterQuery is ""', ->
      @controller.set('filterQuery', "")
      expect(@controller.get('newModelText') == "Contact").toBeTruthy()

    it 'is equal to filterQuery when filterQuery is defined', ->
      @controller.set('filterQuery', "basketball jones")
      expect(@controller.get('newModelText') == @controller.get('filterQuery')).toBeTruthy()

