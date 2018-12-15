import QtQuick 2.7
import QtQuick.Controls 2.2

BusyIndicator {
    id: busyIndicator
    width: 50
    height: 50
    running: false
    anchors.centerIn: parent
    opacity: running
    visible: opacity > 0
    Behavior on opacity { NumberAnimation { duration: 350 } }
}
