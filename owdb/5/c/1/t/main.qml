import QtQuick 2.7
import Application.Resources 1.0

Image {
    y: 15
    x: 0
    id: icon
    width: 64
    height: 64
    source: Resource.images.other.owicon
    sourceSize: Qt.size(64, 64)
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.topMargin: 10
}
