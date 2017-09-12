# fr-bounding-boxes

[![npm version](https://badge.fury.io/js/%40etalab%2Ffr-bounding-boxes.svg)](https://badge.fury.io/js/%40etalab%2Ffr-bounding-boxes)
[![XO code style](https://img.shields.io/badge/code_style-XO-5ed9c7.svg)](https://github.com/sindresorhus/xo)

> Bounding boxes for French administrative levels

Rectangles englobants des contours administratifs français

## Données

4 niveaux administratifs sont disponibles :

* Communes
* EPCI
* Départements
* Régions

Exemple :

```json
{
  "name": "Saint-Élie",
  "id": "fr:commune:97358",
  "bbox": [-53.4329,3.9045,-52.7887,5.0660]
}
```

Les identifiants utilisés sont des [geoids](https://github.com/etalab/geoids).

## Accéder aux données

### Via unpkg

```bash
curl -L https://unpkg.com/@etalab/fr-bounding-boxes@latest/dist/communes.json

curl -L https://unpkg.com/@etalab/fr-bounding-boxes@latest/dist/epci.json

curl -L https://unpkg.com/@etalab/fr-bounding-boxes@latest/dist/departements.json

curl -L https://unpkg.com/@etalab/fr-bounding-boxes@latest/dist/regions.json
```

### Via npm ou yarn

```bash
npm install @etalab/fr-bounding-boxes
```

```js
// Minimal import
const communes = require('@etalab/fr-bounding-boxes/communes')

// Regular way
const {communes} = require('@etalab/fr-bounding-boxes')
```

NB : Les données se trouvent dans le dossier `dist`.

## Construction des données

Les rectangles englobants sont construits à partir de données [ADMIN EXPRESS](professionnels.ign.fr/adminexpress) produites par l'[IGN](http://www.ign.fr/).

```bash
yarn && yarn build
```

## Licences

### Licence applicable aux données

[Licence ouverte 2.0](https://www.etalab.gouv.fr/licence-ouverte-open-licence)

### Licence applicable au code

MIT
