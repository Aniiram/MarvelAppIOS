# MarvelAppIOS

[![version](https://img.shields.io/badge/version-v1.0-green.svg)](https://github.com/Aniiram/MarvelAppIOS)
[![Supported languages](https://img.shields.io/badge/languages-swift-green.svg)](https://github.com/Aniiram/MarvelAppIOS)
[![Platform](https://img.shields.io/badge/platform-iPhone%20%7C%20iPad-green.svg)](https://github.com/Aniiram/MarvelAppIOS)

This project uses Marvel API in the next accomplished features:

* List the Marvel Super Heroes
* Have a detail page with the Marvel Super Hero image, description, and some details of the comics, events, stories and events it takes part in.
* Find any Super Hero by it's name, implementing a search bar
* Mark a Super Hero as favourite and list them.

### Architecture

This project uses MVC design pattern. This project has a layer of Network that handels the requests to Marvel API. 

The base of this project is a Tab Bar View Controller that have a Navigation View Controller in each Tab in order to keep the user navigation in the respective Tab Bar. For each Tab it also has a View Controller with an abstraction of Collection View Controller as first View Controller. Each view controller has it's own Data Source in order to process and get the data for the Collection View. Each element of the Collection View Controller navigates to the Detail View Controller where it shows the detail of the Super Hero.

It also works on portrait and landscape and have a costum transition animation between the first View Controller and the Detail View Controller

### Requirements

- iOS 12+

### Installation

- Download repo
- Open xcode
- Run

### Screenshots

<img src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.26.20.png" data-canonical-src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.26.20.png" width="200" height="400" />
<img src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.27.05.png" data-canonical-src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.27.05.png" width="200" height="400" />
<img src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.27.15.png" data-canonical-src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.27.15.png" width="400" height="200" />
<img src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.26.56.png" data-canonical-src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.26.56.png" width="200" height="400" />
<img src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.27.30.png" data-canonical-src="Screenshots/Screen%20Shot%202019-01-30%20at%2019.27.30.png" width="400" height="200" />
