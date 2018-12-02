import QtQuick 2.7

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
        color: "#444047"
    }
}
