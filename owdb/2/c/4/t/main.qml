import QtQuick 2.7
import Application 1.0

Item {
    y: 238
    x: 43
    id: todaysWeather
    height: 250
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Settings.theme === 'Dark' ? "#404447" : "#e2e2e2"
        Behavior on color { SmoothColorAnimation {} }
    }
}
