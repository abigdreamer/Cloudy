import QtQuick 2.7
import QtGraphicalEffects 1.0
import Application.Resources 1.0
import QtQuick.Window 2.3

Item {
    id: channelImage
    width: 48
    height: 48
    anchors.left: parent.left
    anchors.leftMargin: 5
    anchors.verticalCenter: parent.verticalCenter
    Image {
        id: image
        anchors.fill: parent
        visible: false
        fillMode: Image.PreserveAspectCrop
        source: watchPane.video
            ? watchPane.video.channelImageUrl
            : Resource.images.other.channel
        sourceSize: Qt.size(width * Screen.devicePixelRatio,
                            width * Screen.devicePixelRatio)
    }
    OpacityMask {
        anchors.fill: image
        source: image
        maskSource: Rectangle {
            width: image.width
            height: image.width
            radius: image.width
        }
    }
}