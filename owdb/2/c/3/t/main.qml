import QtQuick 2.7
import Application 1.0

Rectangle {
    y: 166
    x: 10
    id: weeksWeather
    height: 95
    anchors.top: todaysWeather.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: Settings.dark ? "#08ffffff" : "#08000000"
            Behavior on color { SmoothColorAnimation {} }
        }
        GradientStop {
            position: 1.0
            color: Settings.dark ? "#01ffffff" : "#01000000"
            Behavior on color { SmoothColorAnimation {} }
        }
    }
    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Settings.dark ? "#404447" : "#e2e2e2"
        Behavior on color { SmoothColorAnimation {} }
    }
}

