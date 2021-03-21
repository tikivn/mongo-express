'use strict';

module.exports = {
  host: 'localhost',
  port: 27017,
  dbName: 'test',
  // eslint-disable-next-line max-len
  makeConnectionUrl: () => 'mongodb://localhost:27017/test?connect=direct',
};
