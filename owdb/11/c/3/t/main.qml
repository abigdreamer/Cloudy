import QtQuick 2.0
import QtQuick.Controls 2.2
import Application 1.0

Item {
    id: channelContainer
    clip: true
    anchors.top: titleContainer.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 60
    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Settings.theme === 'Dark' ? "#404447" : "#e2e2e2"
        Behavior on color { SmoothColorAnimation {} }
    }
}
