import QtQuick 2.8
import QtQuick.Controls 2.2

ScrollView {
    id: container
    clip: true
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.top: player.bottom
    anchors.bottom: parent.bottom
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AsNeeded
    ScrollBar.vertical.interactive: false
}
