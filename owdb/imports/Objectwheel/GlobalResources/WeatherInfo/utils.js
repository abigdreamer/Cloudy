.pragma library
.import WeatherInfo 1.0 as WeatherInfo

function toQueryCurrentUrl(coord, metric, lang) {
    return  WeatherInfo.Constants.apiUrl + 'weather?mode=json&APPID=' + WeatherInfo.Constants.apiKey +
            '&lang=' + lang +
            '&lat=' + coord.latitude.toFixed(2) +
            '&lon=' + coord.longitude.toFixed(2) +
            '&units=' + (metric ? 'metric' : 'imperial')
}

function toQueryForecastUrl(coord, metric, lang) {
    return WeatherInfo.Constants.apiUrl + 'forecast?mode=json&APPID=' + WeatherInfo.Constants.apiKey +
            '&lang=' + lang +
            '&lat=' + coord.latitude.toFixed(2) +
            '&lon=' + coord.longitude.toFixed(2) +
            '&units=' + (metric ? 'metric' : 'imperial')
}

function toQueryCityListUrl(cityName, metric, lang) {
    return WeatherInfo.Constants.apiUrl + 'find?mode=json&APPID=' + WeatherInfo.Constants.apiKey +
            '&type=like&sort=population&cnt=30' +
            '&q=' + cityName +
            '&lang=' + lang +
            '&units=' + (metric ? 'metric' : 'imperial')
}

function toCurrentWeatherObject(response) {
    return {
        "city": response.name,
        "country": response.sys.country,
        "iconName": response.weather[0].icon,
        "weatherDescription": response.weather[0].description, // String
        "temp": response.main.temp, // Metric: Celsius, Imperial: Fahrenheit
        "tempMax": response.main.temp_max, // Metric: Celsius, Imperial: Fahrenheit
        "tempMin": response.main.temp_min, // Metric: Celsius, Imperial: Fahrenheit
        "humidity": response.main.humidity, // %
        "pressure": response.main.pressure, // hPa
        "windSpeed": response.wind.speed, // Metric: meter/sec, Imperial: miles/hour.
        "cloudiness": response.clouds.all // %
    }
}

function toCityListObject(response) {
    return {
        "city": response.name,
        "country": response.sys.country,
        "iconName": response.weather[0].icon,
        "weatherDescription": response.weather[0].description, // String
        "longitude": response.coord.lon,
        "latitude": response.coord.lat,
        "temp": response.main.temp, // Metric: Celsius, Imperial: Fahrenheit
        "humidity": response.main.humidity, // %
        "pressure": response.main.pressure, // hPa
        "windSpeed": response.wind.speed, // Metric: meter/sec, Imperial: miles/hour.
        "cloudiness": response.clouds.all // %
    }
}

function toForecastWeatherObject(response) {
    return {
        "iconName": response.weather[0].icon,
        "weatherDescription": response.weather[0].description, // String
        "date": new Date(response.dt_txt),
        "temp": response.main.temp, // Metric: Celsius, Imperial: Fahrenheit
    }
}

function toForecastList(response) {
    var finalList = []
    for (var i = 8; i < response.list.length; i+=8)
        finalList.push(response.list[i])
    return finalList
}

function toCityList(response) {
    var finalList = []
    for (var i = 0; i < response.list.length; ++i)
        finalList.push(response.list[i])
    return finalList
}
