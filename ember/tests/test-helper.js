import resolver from './helpers/resolver';
import setupFixtures from './helpers/setup-fixtures';
import {
  setResolver
} from 'ember-qunit';

setResolver(resolver);
setupFixtures();