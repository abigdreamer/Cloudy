import QtQuick 2.8
import Application 1.0

Rectangle {
    height: 100
    color: Settings.theme === 'Dark' ? "#10ffffff" : "#05000000"
    Behavior on color { SmoothColorAnimation {} }

    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Settings.theme === 'Dark' ? "#505050" : "#e2e2e2"
        Behavior on color { SmoothColorAnimation {} }
    }
}
