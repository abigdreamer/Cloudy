// citiesPane.js
.import Application 1.0 as App
.import WeatherInfo 1.0 as WeatherInfo
.import QtPositioning 5.2 as QP
.import "weatherPane.js" as WeatherPaneJS

function citiesPane_onCompleted() {
    cityList.jumpToCity.connect(cityList_onJumpToCity)
    citySearchList.cityAdded.connect(citySearchList_onCityAdded)
    cleanSearchFieldButton.clicked.connect(cleanSearchFieldButton_onClicked)
    searchField.textEdited.connect(searchField_onTextEdited)
    addRoundButton.clicked.connect(addRoundButton_onClicked)
    addFinishButton.clicked.connect(addFinishButton_onClicked)
    App.Settings.measurementSystemChanged.connect(searchField_onTextEdited)
    addCityPane.y = Qt.binding(function() { return addCityPane.height })
}

function addFinishButton_onClicked() {
    addCityPane.y = Qt.binding(function() { return addCityPane.height })
}

function addRoundButton_onClicked() {
    addCityPane.y = 0
    addCityPane.x = 0
}

function searchField_onTextEdited() {    
    noResultLabel.visible = searchField.text === ""
    busyIndicator.running = true
    citySearchList.model = []
    
    App.Utils.suppressCall(1000, searchField, function() {
        var city = searchField.text
        var lang = App.Settings.language
        var metric = App.Settings.isMetric()

        citySearchList.model = []

        if (city === "") {
            busyIndicator.running = false
            noResultLabel.visible = true
            return
        }
        
        searchField.enabled = false

        WeatherInfo.Fetch.getCityList(city, metric, lang, function(value, err) {        
            searchField.enabled = true
            busyIndicator.running = false
            if (err) {
                console.log(err)
                noResultLabel.visible = true
                return
            }
            citySearchList.model = value
            noResultLabel.visible = value.length === 0
        })
    })
}

function cleanSearchFieldButton_onClicked() {
    searchField.text = ""
    searchField_onTextEdited()
}

function citySearchList_onCityAdded(modelData) {
    if (typeof cityList.model == "undefined")
        cityList.model = []
    var model = cityList.model
    model.push(modelData)
    cityList.model = model
}

function cityList_onJumpToCity(modelData) {
    var coord = QP.QtPositioning.coordinate(modelData.latitude, modelData.longitude)
    weatherPane.jumpToCoord(coord)
    applicationWindow.tabBar.currentIndex = 1
}
