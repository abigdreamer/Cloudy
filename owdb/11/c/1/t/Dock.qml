import QtQuick 2.9
import QtMultimedia 5.8
import QtGraphicalEffects 1.12
import Application 1.0

// videoPlayer: Video
// anchor.fill videoPlayer
Item {
    id: root
    anchors.fill: videoPlayer
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        preventStealing: true
        propagateComposedEvents: true
        onEntered: {
            d.fadeInFast()
            hidetimer.restart()
        }
        onExited: {
            var preventHiding = false
            for (var i = 0; i < mask.children.length; ++i) {
                if (Utils.contains(mask.children[i], Qt.point(
                                       mouseArea.mouseX, mouseArea.mouseY)))
                    preventHiding = true
            }

            if (!preventHiding)
                d.fadeOutFast()
            hidetimer.stop()
        }
        onPositionChanged: {
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
                return video.play()
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
                id: maskItem
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

    Item {
        id: contentItem
        anchors.fill: parent
        visible: opacity > 0
        Behavior on opacity
        { NumberAnimation { duration: d.fadeFast ? 150 : 400 } }
    }
    
    QtObject {
        id: d
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
            dockHid(!yes)
        }
    }
    
    signal dockHid(bool yes)
    property var videoPlayer: null
    default property alias contentData: contentItem.data
}
