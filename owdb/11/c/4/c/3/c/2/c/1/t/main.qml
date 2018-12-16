import QtQuick 2.7
import QtGraphicalEffects 1.0
import Application.Resources 1.0
import QtQuick.Window 2.3

Item {
    y: 13
    x: 0
    id: channelImage
    width: 40
    height: 40
    anchors.left: parent.left
    anchors.leftMargin: 10
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
    
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Qt.openUrlExternally('https://www.youtube.com/channel/%1'
                                        .arg(watchPane.video.channelId))
    }
}