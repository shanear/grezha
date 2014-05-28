localforage.setDriver('localStorageWrapper')

emq.globalize()
setResolver(App.__container__)
App.setupForTesting()
App.injectTestHelpers()