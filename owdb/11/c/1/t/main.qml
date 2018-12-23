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
            text: qsTr("This video is now playing in picture-in-picture mode")
        }
    }

    Window {
        id: window
        flags: Qt.Tool | Qt.FramelessWindowHint
        color: player.color
    }

    VideoPlayer {
        id: video
        anchors.centerIn: parent
        width: player.width
        core.autoPlay: true
        core.muted: false
        info: player.info
        height: player.height
        core.onStatusChanged: {
            if (video.core.status === MediaPlayer.Buffering
                    || video.core.status === MediaPlayer.Loading) {
                return playerBusyIndicator.running = true
            }
            playerBusyIndicator.running = false
        }
        onStaysOnTop: {
            if (yes) {
                window.flags |= (Qt.WindowStaysOnTopHint | Qt.NoDropShadowWindowHint)
                window.show()
            } else {
                window.flags &= ~(Qt.WindowStaysOnTopHint | Qt.NoDropShadowWindowHint)
                window.show()
            }
        }
        onDetach: {
            if (yes) {
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

    function calculatedHeight() {
        var v = Utils.getVideo(info, video.quality)
        if (!v || typeof v === "undefined")
            return video.width / 1.777
        var ratio = v.width / video.width
        return v.height / ratio
    }
    
    property alias core: video.core
    property var info: []
}
