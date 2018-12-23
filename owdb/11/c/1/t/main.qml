import QtQuick 2.9
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtMultimedia 5.9
import Application 1.0
import Application.Resources 1.0
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3

Rectangle {
    id: player
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: Math.min(calculatedHeight(), width)
    Behavior on height { NumberAnimation {} }
    color: "black"
    
    ColumnLayout {
        anchors.centerIn: parent
        width: 200
        height: 130
        spacing: 15
        Image {
            fillMode: Image.PreserveAspectFit
            source: Resource.images.player.pip
            Layout.fillHeight: true
            Layout.fillWidth: true
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
        }
        Text {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            color: "#A4A4A4"
            text: qsTr("This video is now playing picture-in-picture mode")
        }
    }

    Window {
        id: window
        color: "black"
        flags: Qt.Window
            | Qt.FramelessWindowHint
            | Qt.BypassWindowManagerHint
            | Qt.X11BypassWindowManagerHint
            | Qt.WindowStaysOnTopHint
            | Qt.NoDropShadowWindowHint
        FrameBorder { anchors.fill: parent }
    }

    VideoPlayer {
        id: video
        anchors.fill: parent
        core.autoPlay: true
        core.muted: false
        info: player.info
        core.onStatusChanged: {
            if (video.core.status === MediaPlayer.Buffering
                    || video.core.status === MediaPlayer.Loading) {
                return playerBusyIndicator.running = true
            }
            playerBusyIndicator.running = false
        }
        onFullScreenChanged: {
            if (fullScreen) {
                d.wasDetached = detached
                detached = true
                window.showFullScreen()
            } else {
                window.showNormal()
                if (!d.wasDetached)
                    Utils.delayCall(1000, video, () => detached = false)
            }
        }
        onStaysOnTopChanged: {
            if (staysOnTop) {
                window.flags |= (Qt.WindowStaysOnTopHint | Qt.NoDropShadowWindowHint)
                window.show()
            } else {
                window.flags &= ~(Qt.WindowStaysOnTopHint | Qt.NoDropShadowWindowHint)
                window.show()
            }
        }
        onDetachedChanged: {
            if (detached) {
                window.width = video.width
                window.height = video.height
                var pos = player.mapToGlobal(0, 0)
                window.x = pos.x + 20
                window.y = pos.y + 20
                window.data.push(video)
                window.show()
            } else {
                player.data.push(video)
                window.hide()
            }
        }
    }

    QtObject {
        id: d
        property bool wasDetached: false
    }

    function calculatedHeight() {
        var v = Utils.getVideo(info, video.quality)
        if (!v || typeof v === "undefined")
            return player.width / 1.777
        var ratio = v.width / player.width
        return v.height / ratio
    }
    
    property alias core: video.core
    property var info: []
}
