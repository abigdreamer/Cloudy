import QtQuick 2.0

Rectangle {
    y: 0
    x: 0
    id: player
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: Math.floor(width / 1.777)
    color: "black"
}
