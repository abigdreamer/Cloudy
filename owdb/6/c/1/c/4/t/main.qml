import QtQuick 2.0
import Application 1.0

Rectangle {
    id: topLine
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: searchField.bottom
    height: 1
    color: Settings.dark ? "#404447" : "#e9e9e9"
    Behavior on color { SmoothColorAnimation {} }
    anchors.topMargin: 10
}
