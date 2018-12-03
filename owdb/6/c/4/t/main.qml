import QtQuick 2.9
import Application 1.0

ListView {
    id: cityList
    clip: true
    anchors.fill: parent
    highlightMoveDuration: 200
    delegate: CityListDelegate {}
    highlight: Rectangle {
        radius: 4
        color: Settings.dark ? "#30ffffff" : "#15000000"
    }
}
