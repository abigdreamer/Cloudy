// cityPane.js
.import Application 1.0 as App
.import WeatherInfo 1.0 as WeatherInfo
.import QtPositioning 5.2 as QP
.import "weatherPane.js" as WeatherPaneJS

function cityPane_onCompleted() {
    cityList.jumpToCity.connect(cityList_onJumpToCity)
    citySearchList.cityAdded.connect(citySearchList_onCityAdded)
    cleanSearchFieldButton.clicked.connect(cleanSearchFieldButton_onClicked)
    searchField.textEdited.connect(searchField_onTextEdited)
    addRoundButton.clicked.connect(addRoundButton_onClicked)
    addFinishButton.clicked.connect(addFinishButton_onClicked)
    App.Settings.measurementSystemChanged.connect(searchField_onTextEdited)
    App.Settings.languageChanged.connect(searchField_onTextEdited)
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
    noResultLabel.visible = false
    busyIndicator.running = true
    citySearchList.model.clear()
    
    App.Utils.suppressCall(1000, searchField, function() {
        var city = searchField.text
        var lang = App.Settings.languageCode()
        var metric = App.Settings.isMetric()

        citySearchList.model.clear()

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
            for (var i = 0; i < value.length; ++i)
                citySearchList.model.append(value[i])
            noResultLabel.visible = value.length === 0
        })
    })
}

function cleanSearchFieldButton_onClicked() {
    searchField.text = ""
    searchField_onTextEdited()
}

function citySearchList_onCityAdded(listElement) {
    cityList.model.append(listElement)
}

function cityList_onJumpToCity(listElement) {
    var coord = QP.QtPositioning.coordinate(listElement.latitude, listElement.longitude)
    weatherPane.jumpToCoord(coord)
    applicationWindow.weatherBar.currentIndex = 0
}
