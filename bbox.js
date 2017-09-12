'use strict'
const computeBbox = require('@turf/bbox')
const through = require('through2').obj
const {stringify} = require('JSONStream')
const {parse} = require('ndjson')

process.stdin
  .pipe(parse())
  .pipe(through((feature, enc, cb) => {
    const bbox = computeBbox(feature)
    const {properties} = feature
    if (properties.INSEE_COM) {
      cb(null, {
        id: `fr:commune:${properties.INSEE_COM}`,
        name: properties.NOM_COM,
        bbox
      })
    } else if (properties.CODE_EPCI) {
      cb(null, {
        id: `fr:epci:${properties.CODE_EPCI}`,
        name: properties.NOM_EPCI,
        bbox
      })
    } else if (properties.INSEE_DEP) {
      cb(null, {
        id: `fr:departement:${properties.INSEE_DEP}`,
        name: properties.NOM_DEP,
        bbox
      })
    } else if (properties.INSEE_REG) {
      cb(null, {
        id: `fr:region:${properties.INSEE_REG}`,
        name: properties.NOM_REG,
        bbox
      })
    } else {
      cb()
    }
  }))
  .pipe(stringify())
  .pipe(process.stdout)
