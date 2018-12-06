// weatherPane.js
.import WeatherInfo 1.0 as WeatherInfo
.import Application 1.0 as App
.import Application.Resources 1.0 as AppRes
.import QtPositioning 5.2 as QP

function weatherPane_onCompleted() {
    updateGps.clicked.connect(updateGps_onClicked)
    map.markerCoordinateActivated.connect(map_onMarkerCoordinateActivated)
    refresh.clicked.connect(refresh_onClicked)
    App.Settings.measurementSystemChanged.connect(refresh_onClicked)
    App.Settings.languageChanged.connect(refresh_onClicked)

    updateGps_onClicked()
    App.Utils.delayCall(1000, weatherPane, function() {
        if (!map.valid)
            goToIstanbul()
    })
}

function getWidgetFromIndex(index) {
    if (index === 0)
        return firstDay
    if (index === 1)
        return secondDay
    if (index === 2)
        return thirdDay
    if (index === 3)
        return fourthDay
}

function map_onMarkerCoordinateActivated(coord) {
    weatherPane.enabled = false
    updateTodaysWeather(coord)
    updateWeeksWeather(coord, function() {
        weatherPane.enabled = true
    })
}

function refresh_onClicked() {
    map_onMarkerCoordinateActivated(map.getMarkerCoordinate())
}

function goToIstanbul() {
    weatherPane.enabled = false
    weatherPane.jumpToCoord(QP.QtPositioning.coordinate(41.00925, 28.95330))
}

function updateGps_onClicked() {
    if (!map.valid) {
        return App.Utils.showMessage(applicationWindow, {
            text: qsTr("Unable to connect to your GPS device."),
            informativeText: map.error
        })
    }

    weatherPane.enabled = false
    map.setMarkerCoordFromGps(map_onMarkerCoordinateActivated)
}

function updateTodaysWeather(coord, notify) {
    var lang = App.Settings.languageCode()
    var metric = App.Settings.isMetric()
    WeatherInfo.Fetch.getCurrent(coord, metric, lang, function(val, err) {
        if (notify) notify()
        if (err) {
            console.log(err)
            return
        }
        if (typeof val.country === "undefined"
            || typeof val.city === "undefined"
            || val.city === "" || val.country === "") {
            city.text = "?????, ??"
            return
        } else {
            city.text = val.city + ', ' + val.country.toUpperCase()
        }
        description.text = App.Utils.toTitleCase(val.weatherDescription)
        temp.text = App.Utils.toCleanTemp(val.temp, metric)
        tempMax.text = App.Utils.toCleanTemp(val.tempMax, metric)
        tempMin.text = App.Utils.toCleanTemp(val.tempMin, metric)
        icon.source = AppRes.Resource.images.weatherCondition[val.icon]
        cloudiness.text = val.cloudiness + "%"
        windSpeed.text = App.Utils.toCleanSpeed(val.windSpeed, metric)
        humidity.text = val.humidity + "%"
        pressure.text = val.pressure + " hPa"
    })
}

function updateWeeksWeather(coord, notify) {
    var lang = App.Settings.languageCode()
    var metric = App.Settings.isMetric()
    WeatherInfo.Fetch.getForecast(coord, metric, lang, function(value, err) {        
        if (notify) notify()
        if (err) {
            console.log(err)
            return
        }
        if (!value || value.length !== 4) {
            console.trace()
            return
        }
        for (var i = 0; i < value.length; ++i) {
            var widget = getWidgetFromIndex(i)
            widget.day = value[i].date.toLocaleString(Qt.locale(lang), "dddd");
            widget.temp = App.Utils.toCleanTemp(value[i].temp, metric)
            widget.icon = AppRes.Resource.images.weatherCondition[value[i].icon]
            widget.description = App.Utils.toTitleCase(value[i].weatherDescription)
        }
    })
}