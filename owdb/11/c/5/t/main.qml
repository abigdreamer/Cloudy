import QtQuick 2.7
import QtQuick.Controls 2.2

BusyIndicator {
    x: 127
    id: commentsBusyIndicator
    height: 50
    width: 50
    running: false
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 50
    anchors.bottom: parent.bottom
}
