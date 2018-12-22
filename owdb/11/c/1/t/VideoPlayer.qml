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
        notifyInterval: 400
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
        function volumeIcon() {
            if (video.muted)
                return Resource.images.player.muted
            if (video.volume > 0.65)
                return Resource.images.player.volumeHigh
            if (video.volume > 0.35)
                return Resource.images.player.volumeMid
            return Resource.images.player.volumeLow
        }
    }

    Dock {
        id: dock
        videoPlayer: video
        // Dock controls
        DockItem {
            id: dockContainer
            x: 8
            y: parent.height - height - 8
            width: parent.width - 16
            height: 30
            //enabled: video.isAvailable()
            RowLayout {
                spacing: 10
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                Button {
                    id: backwardButton
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
                    
                    onPressed: NumberAnimation {
                        target: backwardButton
                        duration: 50
                        property: "scale"
                        to: 0.7
                    }
                    onReleased: NumberAnimation {
                        target: backwardButton
                        duration: 50
                        property: "scale"
                        to: 1.0
                    }
                }
                Button {
                    id: playButton
                    Layout.alignment: Qt.AlignVCenter
                    width: 19
                    height: 19
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
                            video.play()
                        }
                    }
                    onPressed: NumberAnimation {
                        target: playButton
                        duration: 50
                        property: "scale"
                        to: 0.7
                    }
                    onReleased: NumberAnimation {
                        target: playButton
                        duration: 50
                        property: "scale"
                        to: 1.0
                    }
                }
                Button {
                    id: forwardButton
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
                    onPressed: NumberAnimation {
                        target: forwardButton
                        duration: 50
                        property: "scale"
                        to: 0.7
                    }
                    onReleased: NumberAnimation {
                        target: forwardButton
                        duration: 50
                        property: "scale"
                        to: 1.0
                    }
                }
                PlayerSlider {
                    Layout.fillWidth: true
                    videoPlayer: video
                    //value: video.position / video.duration
                }
                Button {
                    id: volumeButton
                    Layout.alignment: Qt.AlignVCenter
                    width: 19
                    height: 19
                    icon.color: "white"
                    icon.source: video.volumeIcon()
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    MouseArea {
                        id: cursor
                        x: -3
                        y: -20
                        width: parent.width + 6
                        height: parent.height + 20
                        hoverEnabled: true
                        onPressed: mouse.accepted = false
                        cursorShape: Qt.PointingHandCursor
                    }
                    onClicked: {
                        qualityButton.checked = false
                        video.muted = !video.muted
                    }
                    onPressed: NumberAnimation {
                        target: volumeButton
                        duration: 50
                        property: "scale"
                        to: 0.7
                    }
                    onReleased: NumberAnimation {
                        target: volumeButton
                        duration: 50
                        property: "scale"
                        to: 1.0
                    }
                    property alias containsMouse: cursor.containsMouse
                }
                Button {
                    id: qualityButton
                    Layout.alignment: Qt.AlignVCenter
                    width: 19
                    height: 19
                    checkable: true
                    rotation: checked ? 45 : 0
                    Behavior on rotation { NumberAnimation { duration: 100 } }
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
                }
            }
        }
        // Volume slider
        DockItem {
            id: volumeSliderDockItem
            x: volumeButton.parent.mapToItem(parent, volumeButton.x, 0).x
               + (volumeButton.width - width) / 2.0
            y: dockContainer.y - height - 5
            visible: !video.muted
                     && (volumeButton.containsMouse || ma.containsMouse)
                     && !qualityButton.checked
            width: 25
            height: 80
            PlayerSlider {
                anchors.fill: parent
                anchors.topMargin: 8
                anchors.bottomMargin: 8
                value: video.volume
                orientation: Qt.Vertical
                onValueChanged: video.volume = value
            }
            MouseArea {
                id: ma
                anchors.fill: parent
                hoverEnabled: true
                onPressed: mouse.accepted = false
                cursorShape: Qt.PointingHandCursor
            }
        }
        // Quality selection container
        DockItem {
            id: qualitySelectionDockItem
            x: qualityButton.parent.mapToItem(parent, qualityButton.x, 0).x
               - width + qualityButton.width
            y: dockContainer.y - height - 5
            visible: qualityButton.checked
            width: playerOptions.width + 10
            height: playerOptions.height + 10
            onVisibleChanged: if (!visible) playerOptions.pop()
            PlayerOptions {
                id: playerOptions
                anchors.centerIn: parent
                maxHeight: root.height - dockContainer.height - 20
                qualities: Utils.getQualities(info)
            }
        }
    }

    onInfoChanged: qualityButton.checked = false
    property var info: null
    property alias player: video
}
