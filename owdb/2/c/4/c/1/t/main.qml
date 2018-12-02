import QtQuick 2.7
import Application.Resources 1.0

Image {
    height: 202
    width: 342
    y: 153
    x: 15
    id: icon
    source: Resource.images.weatherCondition["01d"]
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: city.bottom
    anchors.bottom: description.top
    fillMode: Image.PreserveAspectFit
    horizontalAlignment: Image.AlignHCenter
    verticalAlignment: Image.AlignVCenter
}
