import QtQuick 2.8

MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onPressed: mouse.accepted = false
    cursorShape: Qt.PointingHandCursor
}
