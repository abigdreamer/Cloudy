pragma Singleton
import QtQuick 2.6
import WeatherInfo 1.0
import "utils.js" as Utils

QtObject {
    function getCurrent(coord, metric, lang, callback) {
        var url = Utils.toQueryCurrentUrl(coord, metric, lang)
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    callback(null, "Server error")
                }
                var response = JSON.parse(xhttp.responseText)
                callback(Utils.toCurrentWeatherObject(response))
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
    
    function getForecast(coord, metric, lang, callback) {
        var url = Utils.toQueryForecastUrl(coord, metric, lang)
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    callback(null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                var dailyDatas = Utils.toForecastList(response)
                var dailyResponses = []
                for (var i = 0; i < dailyDatas.length; i++)
                    dailyResponses.push(Utils.toForecastWeatherObject(dailyDatas[i]))
                callback(dailyResponses)
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
    
    function getCityList(cityName, metric, lang, callback) {
        var url = Utils.toQueryCityListUrl(cityName, metric, lang)
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    callback(null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                var dailyDatas = Utils.toCityList(response)
                var dailyResponses = []
                for (var i = 0; i < dailyDatas.length; i++)
                    dailyResponses.push(Utils.toCityListObject(dailyDatas[i]))
                callback(dailyResponses)
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
}
