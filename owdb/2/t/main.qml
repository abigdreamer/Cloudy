import QtQuick 2.7
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0

Page {
    id: weatherPane
    width: 342
    height: 608
    Component.onCompleted: WeatherPaneJS.weatherPane_onCompleted()
    title: qsTr("Weather")
}