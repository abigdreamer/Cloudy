// weatherPane.js
.import WeatherInfo 1.0 as WeatherInfo
.import Application 1.0 as App
.import Application.Resources 1.0 as AppRes

function weatherPane_onCompleted() {
    updateGps.clicked.connect(updateGps_onClicked)
    map.markerCoordinateActivated.connect(map_onMarkerCoordinateActivated)
    refresh.clicked.connect(refresh_onClicked)
    if (map.valid)
        updateGps_onClicked()
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
    var metric = App.Settings.metricSystem
    updateTodaysWeather(coord, metric)
    updateWeeksWeather(coord, metric, function() {
        weatherPane.enabled = true
    })
}

function refresh_onClicked() {
    map_onMarkerCoordinateActivated(map.getMarkerCoordinate())
}

function updateGps_onClicked() {
    weatherPane.enabled = false
    map.setMarkerCoordFromGps(map_onMarkerCoordinateActivated)
}

function updateTodaysWeather(coord, metric, notify) {
    var lang = App.Settings.language
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

function updateWeeksWeather(coord, metric, notify) {
    var lang = App.Settings.language
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
            widget.day = value[i].date.toLocaleString(Qt.locale(), "dddd");
            widget.temp = App.Utils.toCleanTemp(value[i].temp, metric)
            widget.icon = AppRes.Resource.images.weatherCondition[value[i].icon]
            widget.description = App.Utils.toTitleCase(value[i].weatherDescription)
        }
    })
}