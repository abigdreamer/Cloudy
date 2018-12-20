import QtQuick 2.9
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4

Rectangle {
    id: player
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: Math.floor(width / 1.777)
    color: "red"
  
    VideoPlayer {
        id: video
        anchors.centerIn: parent
        width: player.width
        height: Math.floor(player.width / 1.777)
        player.source: "file:///Users/omergoktas/Desktop/Kara Kutu/BigBuckBunny.mp4"
        player.autoPlay: true
        player.muted: true
        dock.dragEnabled: false
    }

  property var videos: ({})
  property url audioUrl
}
