import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Application 1.0

TextField {
    id: searchField
    placeholderText: qsTr("Search")
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.rightMargin: 10
    anchors.leftMargin: 10
    anchors.topMargin: 10
    leftPadding: 8
    rightPadding: 0
    bottomPadding: 0
    topPadding: 0
    height: 40
    selectByMouse: true
    background: Rectangle {
        color: Settings.theme === 'Dark' ? "#30ffffff" : "#15000000"
        Behavior on color { SmoothColorAnimation {} }
        radius: 4
    }
}
