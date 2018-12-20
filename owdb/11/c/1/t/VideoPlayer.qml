import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import Application 1.0
import Application.Resources 1.0

Item {
    id: root

    Video {
        id: video
        anchors.fill: parent
        function isAvailable() {
            return availability === MediaPlayer.Available
                 && error === MediaPlayer.NoError
                 && status !== MediaPlayer.InvalidMedia
                 && status !== MediaPlayer.UnknownStatus
                 && status !== MediaPlayer.NoMedia
        }
        function playerState() {
            if (playbackState === MediaPlayer.PlayingState)
                return 'playing'
            if (playbackState === MediaPlayer.StoppedState 
                    || status === MediaPlayer.Stalled
                    || status === MediaPlayer.EndOfMedia)
                return 'stopped'
            if (playbackState === MediaPlayer.PausedState)
                return 'paused'
        }
    }

    Dock {
        id: dock
        videoPlayer: video
        // Dock controls
        Rectangle {
            id: dockContainer
            x: 8
            y: parent.height - height - 8
            width: parent.width - 16
            height: 35
            radius: 10
            color: "#55091118"
            RowLayout {
                spacing: 10
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                Button {
                    Layout.alignment: Qt.AlignVCenter
                    width: 19
                    height: 19
                    enabled: video.seekable
                    icon.color: "white"
                    icon.source: Resource.images.player.backward
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    Cursor {}
                    onClicked: video.seek(video.position > 15000
                                          ? video.position - 15000
                                          : 0)
                }
                Button {
                    Layout.alignment: Qt.AlignVCenter
                    width: 19
                    height: 19
                    enabled: video.isAvailable()
                    icon.color: "white"
                    icon.source: {
                        if (video.playerState() === 'playing')
                            return Resource.images.player.pause
                        if (video.playerState() === 'paused')
                            return Resource.images.player.play
                        if (video.playerState() === 'stopped')
                            return Resource.images.player.stop
                    }
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    Cursor {}
                    onClicked: {
                        if (video.playerState() === 'playing')
                            return video.pause()
                        if (video.playerState() === 'paused')
                            return video.play()
                        if (video.playerState() === 'stopped') {
                            video.stop()
                            video.seek(0)
                            video.play()
                        }
                    }
                }
                Button {
                    Layout.alignment: Qt.AlignVCenter
                    width: 19
                    height: 19
                    enabled: video.seekable
                    icon.color: "white"
                    icon.source: Resource.images.player.forward
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    Cursor {}
                    onClicked: video.seek(video.position + 15000)
                }
                PlayerSlider {
                    Layout.fillWidth: true
                    videoPlayer: video
                }
                Button {
                    id: volumeControl
                    Layout.alignment: Qt.AlignVCenter
                    width: 19
                    height: 19
                    enabled: video.seekable
                    icon.color: "white"
                    icon.source: Resource.images.player.volumeMax
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    Cursor {
                        id: cursor
                        hoverEnabled: true
                    }
                    onClicked: video.seek(video.position + 15000)
                    property alias containsMouse: cursor.containsMouse
                }
                Button {
                    Layout.alignment: Qt.AlignVCenter
                    width: 19
                    height: 19
                    enabled: video.seekable
                    icon.color: "white"
                    icon.source: Resource.images.player.quality
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    Cursor {}
                    onClicked: video.seek(video.position + 15000)
                }
            }
        }
        // Volume slider
         Rectangle {
            x: dockContainer.mapToItem(parent, volumeControl.x, 0).x + 
               Math.floor(Math.abs(volumeControl.width - width) / 2.0)
            y: dockContainer.y - height - 8
            visible: volumeControl.containsMouse
            width: 28
            height: 80
            radius: 8
            color: "#55091118"
            Slider {
                anchors.fill: parent
                value: video.volume
                orientation: Qt.Vertical
            }
        }
    }
    property alias player: video
}
