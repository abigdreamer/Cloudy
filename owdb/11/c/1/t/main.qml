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
    color: "black"
    
    VideoPlayer {
        id: video
        anchors.centerIn: parent
        width: player.width
        height: Math.floor(player.width / 1.777)
        player.source: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4"
        player.autoPlay: false
        player.muted: true
    }

  property var videos: ({})
  property url audioUrl
}
