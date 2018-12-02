pragma Singleton
import QtQuick 2.6

QtObject {
    readonly property var images: {
        "weatherCondition": {
            "01d": Qt.resolvedUrl('./images/weather-condition/01d.png'),
            "01n": Qt.resolvedUrl('./images/weather-condition/01n.png'),
            "02d": Qt.resolvedUrl('./images/weather-condition/02d.png'),
            "02n": Qt.resolvedUrl('./images/weather-condition/02n.png'),
            "03d": Qt.resolvedUrl('./images/weather-condition/03d.png'),
            "03n": Qt.resolvedUrl('./images/weather-condition/03n.png'),
            "04d": Qt.resolvedUrl('./images/weather-condition/04d.png'),
            "04n": Qt.resolvedUrl('./images/weather-condition/04n.png'),
            "09d": Qt.resolvedUrl('./images/weather-condition/09d.png'),
            "09n": Qt.resolvedUrl('./images/weather-condition/09n.png'),
            "10d": Qt.resolvedUrl('./images/weather-condition/10d.png'),
            "10n": Qt.resolvedUrl('./images/weather-condition/10n.png'),
            "11d": Qt.resolvedUrl('./images/weather-condition/11d.png'),
            "11n": Qt.resolvedUrl('./images/weather-condition/11n.png'),
            "13d": Qt.resolvedUrl('./images/weather-condition/13d.png'),
            "13n": Qt.resolvedUrl('./images/weather-condition/13n.png'),
            "50d": Qt.resolvedUrl('./images/weather-condition/50d.png'),
            "50n": Qt.resolvedUrl('./images/weather-condition/50n.png')
        },
        "other": {
            "about": Qt.resolvedUrl('./images/other/about.png'),
            "arrowDown": Qt.resolvedUrl('./images/other/arrow-down.png'),
            "arrowUp": Qt.resolvedUrl('./images/other/arrow-up.png'),
            "arrow": Qt.resolvedUrl('./images/other/arrow.png'),
            "back": Qt.resolvedUrl('./images/other/back.png'),
            "cloudiness": Qt.resolvedUrl('./images/other/cloudiness.png'),
            "drawer": Qt.resolvedUrl('./images/other/drawer.png'),
            "gps": Qt.resolvedUrl('./images/other/gps.png'),
            "home": Qt.resolvedUrl('./images/other/home.png'),
            "humidity": Qt.resolvedUrl('./images/other/humidity.png'),
            "marker": Qt.resolvedUrl('./images/other/marker.png'),
            "menu": Qt.resolvedUrl('./images/other/menu.png'),
            "owicon": Qt.resolvedUrl('./images/other/owicon.png'),
            "pressure": Qt.resolvedUrl('./images/other/pressure.png'),
            "refresh": Qt.resolvedUrl('./images/other/refresh.png'),
            "settings": Qt.resolvedUrl('./images/other/settings.png'),
            "weather": Qt.resolvedUrl('./images/other/weather.png'),
            "wind": Qt.resolvedUrl('./images/other/wind.png'),
            "myCities": Qt.resolvedUrl('./images/other/my-cities.svg'),
        }
    }
}