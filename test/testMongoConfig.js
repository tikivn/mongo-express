'use strict';

module.exports = {
  host: 'uat-dandelion-mongodb.svr.tiki.services',
  port: 27017,
  dbName: 'dandelion_uat',
  // eslint-disable-next-line max-len
  makeConnectionUrl: () => 'mongodb://dandelionad:M0n90Bak82F0r3V3r@uat-dandelion-mongodb.svr.tiki.services:27017/dandelion_uat?connect=direct&authSource=admin',
};
