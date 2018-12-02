import QtQuick 2.7
import Application.Resources 1.0

Image {
    id: logo
    width: homePane.availableWidth / 2
    height: homePane.availableHeight / 2
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -50
    fillMode: Image.PreserveAspectFit
    source: Resource.images.other.owicon
}