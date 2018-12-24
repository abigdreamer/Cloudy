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
                opacity: contentItem.children[index].opacity
                color: contentItem.children[index].visible
                       ? "white" : "transparent"
            }
        }
    }

    OpacityMask {
        anchors.fill: blur
        source: blur
        maskSource: mask
        id: opacityMask
        cached: false
        visible: opacity > 0
        Behavior on opacity
        { NumberAnimation { duration: d.fadeFast ? 150 : 400 } }
    }

    Timer {
        id: hidetimer
        interval: 3000
        repeat: false
        running: false
        onTriggered: d.fadeOutSlow()
    }

     MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        preventStealing: false
        propagateComposedEvents: true
        onEntered: {
            d.fadeInFast()
            hidetimer.restart()
        }
        onExited: {
            if (mouseX <= 10 || mouseX >= width - 10
                    || mouseY <= 10 || mouseY >= height - 10
                    || d.velocity > 9) {
                d.fadeOutFast()
            }
            hidetimer.stop()
        }
        onPositionChanged: {
            d.velocity = Math.max(Math.abs(d.lastPos.x - mouse.x),
                                  Math.abs(d.lastPos.y - mouse.y))
            d.lastPos = Qt.point(mouse.x, mouse.y)
            if (containsMouse) {
                d.fadeInFast()
                hidetimer.restart()
            }
        }
        onClicked: {
            if (!video.isAvailable())
                return
            if (video.playerState() === 'playing')
                return video.pause()
            if (video.playerState() === 'paused')
                return video.play()
            if (video.playerState() === 'stopped')
                return video.stop()
        }
        Component.onCompleted: {
            video.statusChanged.connect(function() {
                if (video.status === MediaPlayer.EndOfMedia
                        || video.status === MediaPlayer.Buffered) {
                    d.fadeInFast()
                }
                if (video.playerState() === 'playing'
                        && video.status === MediaPlayer.Buffered) {
                    hidetimer.restart()
                }
            })
            video.playbackStateChanged.connect(function() {
                d.fadeInFast()
            })
        }
    }

    Item {
        id: contentItem
        anchors.fill: parent
        visible: opacity > 0
        Behavior on opacity
        { NumberAnimation { duration: d.fadeFast ? 150 : 400 } }
    }
    
    QtObject {
        id: d
        property point lastPos: Qt.point(0, 0)
        property real velocity: 0
        property bool fadeFast: false
        function fadeInFast() {
            d.fadeFast = true
            setVisible(true)
        }
        function fadeOutFast() {
            d.fadeFast = true
            setVisible(false)
        }
        function fadeOutSlow() {
            d.fadeFast = false
            setVisible(false)
        }
        function setVisible(yes) {
            if (!yes && videoPlayer.playerState() !== 'playing')
                return
            opacityMask.opacity = yes ? 1 : 0
            contentItem.opacity = yes ? 1 : 0
        }
    }

    property var videoPlayer: null
    default property alias contentData: contentItem.data
}
