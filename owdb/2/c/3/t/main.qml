import QtQuick 2.7

Rectangle {
    y: 166
    x: 10
    id: weeksWeather
    height: 95
    anchors.top: todaysWeather.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#08ffffff" }
        GradientStop { position: 1.0; color: "#01ffffff" }
    }
    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#404447"
    }
}

