import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

BusyIndicator {
    id: playerBusyIndicator
    height: 50
    width: 50
    anchors.centerIn: parent
    Material.accent: "white"
    running: false
}
