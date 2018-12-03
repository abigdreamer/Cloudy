import QtQuick 2.0
import Application 1.0

Rectangle {
    id: bottomLine
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: citySearchList.bottom
    height: 1
    color: Settings.dark ? "#404447" : "#e9e9e9"
}
