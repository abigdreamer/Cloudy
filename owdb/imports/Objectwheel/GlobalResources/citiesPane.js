// citiesPane.js
.import Application 1.0 as App
.import WeatherInfo 1.0 as WeatherInfo

function citiesPane_onCompleted() {
    searchField.textEdited.connect(searchField_onTextEdited)
    addRoundButton.clicked.connect(addRoundButton_onClicked)
    addFinishButton.clicked.connect(addFinishButton_onClicked)
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
    citySearchList.model = []
    
    var city = searchField.text
    if (city === "") {
        busyIndicator.running = false
        noResultLabel.visible = true
        return
    }
    
    busyIndicator.running = true
    
    App.Utils.suppressCall(1000, searchField, function() {
        var lang = App.Settings.language
        var metric = App.Settings.metric

        if (city === "") {
            busyIndicator.running = false
            noResultLabel.visible = true
            return
        }
        
        searchField.enabled = false
        busyIndicator.running = false

        WeatherInfo.Fetch.getCityList(city, metric, lang, function(value, err) {        
            searchField.enabled = true
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
