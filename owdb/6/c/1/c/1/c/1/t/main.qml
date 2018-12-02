import QtQuick 2.7
import QtQuick.Controls 2.2

BusyIndicator {
    id: busyIndicator
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.margins: 2
    running: false
    width: height
}
