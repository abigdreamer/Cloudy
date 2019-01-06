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
        onEntered: {
            d.fadeInFast()
            hidetimer.restart()
        }
        onExited: {
            // First the exited signal is executed in the object we are leaving,
            // then entered is called in the object we are entering. So, we are
            // waiting until the event loop to finish, hence entering object will
            // get an entered signal and it will update its containsMouse property
            Qt.callLater(function() {
                var preventHiding = false
                for (var i = 0; i < contentItem.children.length; ++i) {
                    var item = contentItem.children[i]
                    if (item.containsMouse)
                        preventHiding = true
                }
    
                if (!preventHiding)
                    d.fadeOutFast()
            })
            hidetimer.stop()
        }
        onPositionChanged: {
            if (containsMouse && !d.isVisible()) {
                d.fadeInFast()
                hidetimer.restart()
            }
        }
        onClicked: {
            if (!videoPlayer.isAvailable())
                return
            if (videoPlayer.playerState() === 'playing') {
                audioPlayer.pause()
                return videoPlayer.pause()
            } if (videoPlayer.playerState() === 'paused') {
                videoPlayer.play()
                return audioPlayer.play()
            } if (videoPlayer.playerState() === 'stopped') {
                audioPlayer.stop()
                videoPlayer.stop()
                videoPlayer.play()
                audioPlayer.play()
            }
        }
        Component.onCompleted: {
            videoPlayer.statusChanged.connect(function() {
                if (videoPlayer.status === MediaPlayer.EndOfMedia
                        || videoPlayer.status === MediaPlayer.Buffered) {
                    d.fadeInFast()
                }
                if (videoPlayer.playerState() === 'playing'
                        && videoPlayer.status === MediaPlayer.Buffered) {
                    hidetimer.restart()
                }
            })
            videoPlayer.playbackStateChanged.connect(function() {
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
        function isVisible() {
            return opacityMask.opacity === 1
        }
    }
    
    signal dockHid(bool yes)
    property var audioPlayer: null
    property var videoPlayer: null
    default property alias contentData: contentItem.data
}
