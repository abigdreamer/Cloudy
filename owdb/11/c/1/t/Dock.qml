import QtQuick 2.9
import QtMultimedia 5.8
import QtGraphicalEffects 1.12

// Set videoPlayer to Video
// anchor.fill videoPlayer
Item {
    id: root

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
        Rectangle {
            x: dockItem.x
            y: dockItem.y
            width: dockItem.width
            height: dockItem.height
            radius: dockItem.radius
        }
    }

    OpacityMask {
        anchors.fill: blur
        source: blur
        maskSource: mask
    }

    Rectangle {
        id: dockItem
        x: 8
        y: root.height - height - 8
        width: videoPlayer.width - 16
        height: 35
        radius: 5
        color: "#55091118"

        MouseArea {
            anchors.fill: parent
            enabled: dragEnabled
            drag.target: parent
            cursorShape: pressed
                         ? Qt.ClosedHandCursor
                         : Qt.ArrowCursor
        }

        onXChanged: {
            if (dragEnabled) {
                if (x < 0)
                    x = 0
                if (x > root.width - width)
                    x = root.width - width
            }
        }

        onYChanged: {
            if (dragEnabled) {
                if (y < 0)
                    y = 0
                if (y > root.height - height)
                    y = root.height - height
            }
        }
    }

    property bool dragEnabled: true
    property var videoPlayer: null
    default property alias contentData: dockItem.data
}
