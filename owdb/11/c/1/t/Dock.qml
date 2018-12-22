import QtQuick 2.9
import QtMultimedia 5.8
import QtGraphicalEffects 1.12

// videoPlayer: Video
// anchor.fill videoPlayer
Item {
    id: root
    anchors.fill: videoPlayer

    FastBlur {
        id: blur
        radius: 100
        visible: false
        source: videoPlayer
        anchors.fill: parent
    }

    Item {
        id: mask
        anchors.fill: blur
        visible: false
        Repeater {
            model: contentItem.children
            Rectangle {
                x: contentItem.children[index].x
                y: contentItem.children[index].y
                width: contentItem.children[index].width
                height: contentItem.children[index].height
                radius: contentItem.children[index].radius
                color: contentItem.children[index].visible
                       ? "white" : "transparent"
            }
        }
    }

    OpacityMask {
        anchors.fill: blur
        source: blur
        maskSource: mask
        id: op
        cached: false
    }

    Item {
        id: contentItem
        anchors.fill: parent
    }

    property var videoPlayer: null
    default property alias contentData: contentItem.data
}
