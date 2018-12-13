import QtQuick 2.9
import QtQuick.Controls 2.2
import Objectwheel.GlobalResources 1.0

Page {
    id: weatherSection
    width: 342
    height: 608
    Component.onCompleted: WeatherSectionJS.weatherSection_onCompleted()
}
