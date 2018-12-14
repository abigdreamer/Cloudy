import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0
import Application.Resources 1.0
import Objectwheel.GlobalResources 1.0
import QtQuick.Controls.Material 2.2

Page {
    id: weatherSection
    width: 342
    height: 608
    Component.onCompleted: WeatherSectionJS.weatherSection_onCompleted()
    title: qsTr("Weather")
}