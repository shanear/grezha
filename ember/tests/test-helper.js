import resolver from './helpers/resolver';
import setupFixtures from './helpers/setup-fixtures';
import {
  setResolver
} from 'ember-qunit';

setResolver(resolver);
setupFixtures();

document.write('<div id="ember-testing-container"><div id="ember-testing"></div></div>');

QUnit.config.urlConfig.push({ id: 'nocontainer', label: 'Hide container'});
var containerVisibility = QUnit.urlParams.nocontainer ? 'hidden' : 'visible';
document.getElementById('ember-testing-container').style.visibility = containerVisibility;
