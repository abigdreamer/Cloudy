import QtQuick 2.8

MouseArea {
    anchors.fill: parent
    onPressed: mouse.accepted = false
    cursorShape: Qt.PointingHandCursor
}