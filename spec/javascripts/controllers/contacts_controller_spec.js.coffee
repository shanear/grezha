
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

  describe 'filteredContacts', ->

    it 'filters names with filterQuery', ->
      @controller.set('filterQuery', "seansie")
      contacts = @controller.get('filteredContacts')

      expect(contacts[0].get('name') == "badazz seansie").toBeTruthy()

    it 'filterQuery is not case sensitive', ->
      @controller.set('filterQuery', "Seansie")
      contacts = @controller.get('filteredContacts')

      expect(contacts[0].get('name') == "badazz seansie").toBeTruthy()

  describe 'newContactText', ->

    it 'should not be undefined', ->
      expect(typeof(@controller.get('newContactText')) == 'undefined').toBeFalsy()

    it 'is "Contact" when filterQuery is ""', ->
      @controller.set('filterQuery', "")
      expect(@controller.get('newContactText') == "Contact").toBeTruthy()

    it 'is equal to filterQuery when filterQuery is defined', ->
      @controller.set('filterQuery', "basketball jones")
      expect(@controller.get('newContactText') == @controller.get('filterQuery')).toBeTruthy()

