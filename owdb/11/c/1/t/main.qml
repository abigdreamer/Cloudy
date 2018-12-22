import QtQuick 2.9
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtMultimedia 5.9
import Application 1.0

Rectangle {
    id: player
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: Math.min(calculatedHeight(), width)
    Behavior on height { NumberAnimation {} }
    color: "black"
    
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
