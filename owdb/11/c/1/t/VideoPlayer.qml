import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import Application 1.0
import Application.Resources 1.0
import QtQuick.Window 2.3

Rectangle {
    id: root
    color: "black"
    
    Video {
        id: video
        notifyInterval: 400
        anchors.fill: parent
        playbackRate: Utils.toPlaybackRate(playerOptions.speed)
        source: info.length ? Utils.getVideo(info, playerOptions.quality).url : ""
        onPositionChanged: {
            playerSlider.value
                    = video.position / Utils.toDurationMs(watchPane.video.duration)
        }
        onPlaybackRateChanged: qualityButton.checked = false
        onPlaybackStateChanged: qualityButton.checked = false
        
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

    Audio {
        id: audio
        muted: video.muted
        volume: video.volume
        playbackRate: video.playbackRate
        source: info.length > 0 ? Utils.getAudio(info).url : ""
        Component.onCompleted: {
            video.playbackStateChanged.connect(function() {
                if (video.playerState() === 'playing')
                    return audio.play()
                if (video.playerState() === 'paused')
                    return audio.pause()
                if (video.playerState() === 'stopped')
                    return audio.stop()
            })
            video.bufferProgressChanged.connect(function() {
                if (video.playerState() === 'playing')
                    return audio.play()
            })
        }
    }
    Dock {
        id: dock
        videoPlayer: video
        onDockHid: if (yes) qualityButton.checked = false

        // Fullscreen controls
        DockItem {
            id: fullScreenContainer
            x: 8
            y: 8
            width: 70
            height: 30
            Row {
                spacing: 10
                anchors.centerIn: parent
                Button {
                    id: fullScreenButton
                    width: 19
                    height: 19
                    checkable: true
                    icon.color: enabled ? "white" : "#707070"
                    icon.source: checked
                                 ? Resource.images.player.normalScreen
                                 : Resource.images.player.fullScreen
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    Cursor {}
                    onClicked: qualityButton.checked = false
                    onPressed: NumberAnimation {
                        target: fullScreenButton
                        duration: 50
                        property: "scale"
                        to: 0.9
                    }
                    onReleased: NumberAnimation {
                        target: fullScreenButton
                        duration: 50
                        property: "scale"
                        to: 1.0
                    }
                }
                Button {
                    id: attachButton
                    width: 19
                    height: 19
                    enabled: !fullScreenButton.checked
                    checkable: true
                    icon.color: enabled ? "white" : "#707070"
                    icon.source: checked
                                 ? Resource.images.player.attach
                                 : Resource.images.player.detach
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    onClicked: qualityButton.checked = false
                    Cursor {}
                    onPressed: NumberAnimation {
                        target: attachButton
                        duration: 50
                        property: "scale"
                        to: 0.9
                    }
                    onReleased: NumberAnimation {
                        target: attachButton
                        duration: 50
                        property: "scale"
                        to: 1.0
                    }
                }
            }
        }
        // Fullscreen controls
        DockItem {
            id: staysOnTopContainer
            x: parent.width - width - 8
            y: 8
            width: 70
            height: 30
            visible: attachButton.checked && !fullScreenButton.checked
            Row {
                spacing: 10
                anchors.centerIn: parent
                Button {
                    id: staysOnTopButton
                    width: 19
                    height: 19
                    checked: true
                    checkable: true
                    icon.color: enabled ? "white" : "#707070"
                    icon.source: checked
                                 ? Resource.images.player.noBalloon
                                 : Resource.images.player.balloon
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    Cursor {}
                    onClicked: qualityButton.checked = false
                    onPressed: NumberAnimation {
                        target: staysOnTopButton
                        duration: 50
                        property: "scale"
                        to: 0.9
                    }
                    onReleased: NumberAnimation {
                        target: staysOnTopButton
                        duration: 50
                        property: "scale"
                        to: 1.0
                    }
                }
                Button {
                    id: dragWindowButton
                    width: 19
                    height: 19
                    icon.color: enabled ? "white" : "#707070"
                    icon.source: Resource.images.player.drag
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: pressed
                                     ? Qt.ClosedHandCursor
                                     : Qt.PointingHandCursor
                        onPressed: {
                            qualityButton.checked = false
                            clickPos  = Qt.point(mouse.x,mouse.y)
                        }
                        onPositionChanged: {
                            var delta = Qt.point(mouse.x - clickPos.x,
                                                 mouse.y - clickPos.y)
                            Window.window.x += delta.x
                            Window.window.y += delta.y
                        }
                        property point clickPos: Qt.point(1 , 1)
                    }
                    onPressed: NumberAnimation {
                        target: dragWindowButton
                        duration: 50
                        property: "scale"
                        to: 0.9
                    }
                    onReleased: NumberAnimation {
                        target: dragWindowButton
                        duration: 50
                        property: "scale"
                        to: 1.0
                    }
                }
            }
        }
        // Dock controls
        DockItem {
            id: dockContainer
            x: 8
            y: parent.height - height - 8
            width: parent.width - 16
            height: 30
            enabled: video.isAvailable()
            RowLayout {
                spacing: 10
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                Button {
                    id: backwardButton
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 19
                    Layout.preferredHeight: 19
                    enabled: video.seekable
                    icon.color: enabled ? "white" : "#707070"
                    icon.source: Resource.images.player.backward
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    Cursor {}
                    onClicked: {
                        audio.seek(video.position - 15000)
                        video.seek(video.position - 15000)
                        qualityButton.checked = false
                    }
                    
                    onPressed: NumberAnimation {
                        target: backwardButton
                        duration: 50
                        property: "scale"
                        to: 0.9
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
                    Layout.preferredWidth: 19
                    Layout.preferredHeight: 19
                    icon.color: enabled ? "white" : "#707070"
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
                        to: 0.9
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
                    Layout.preferredWidth: 19
                    Layout.preferredHeight: 19
                    enabled: video.seekable
                    icon.color: enabled ? "white" : "#707070"
                    icon.source: Resource.images.player.forward
                    icon.width: width
                    icon.height: height
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    Cursor {}
                    onClicked: {
                        qualityButton.checked = false
                        audio.seek(video.position + 15000)
                        video.seek(video.position + 15000)
                    }
                    onPressed: NumberAnimation {
                        target: forwardButton
                        duration: 50
                        property: "scale"
                        to: 0.9
                    }
                    onReleased: NumberAnimation {
                        target: forwardButton
                        duration: 50
                        property: "scale"
                        to: 1.0
                    }
                }
                Text {
                    id: leftDuration
                    text: !watchPane.video || typeof watchPane.video === "undefined"
                          ? "--:--"
                          : Utils.durationMsToString(video.position)
                    color: enabled ? "white" : "#707070"
                }
                PlayerSlider {
                    id: playerSlider
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.preferredHeight: 12
                    from: 0.0
                    to: 1.0
                    videoPlayer: video
                    onMoved: {
                        video.seek(value * Utils.toDurationMs(watchPane.video.duration))
                        audio.seek(value * Utils.toDurationMs(watchPane.video.duration))
                        qualityButton.checked = false
                    }
                    Cursor {}
                }
                Text {
                    id: rightDuration
                    text: !watchPane.video || typeof watchPane.video === "undefined"
                          ? "--:--"
                          : Utils.durationMsToString(Utils.toDurationMs(watchPane.video.duration))
                    color: enabled ? "white" : "#707070"
                }
                Button {
                    id: volumeButton
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 19
                    Layout.preferredHeight: 19
                    icon.color: enabled ? "white" : "#707070"
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
                        to: 0.9
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
                    Layout.preferredWidth: 19
                    Layout.preferredHeight: 19
                    checkable: true
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    background: Item {}
                    TintImage {
                        rotation: parent.checked ? 45 : 0
                        Behavior on rotation { NumberAnimation { duration: 100 } }
                        tintColor: enabled ? "white" : "#707070"
                        icon.source: Resource.images.player.quality
                        anchors.fill: parent
                    }
                    Image {
                        width: 13
                        height: 9
                        sourceSize: Qt.size(13 * Screen.devicePixelRatio,
                                            9 * Screen.devicePixelRatio)
                        source: Resource.images.player.hd
                        anchors.top: parent.top
                        anchors.right: parent.right
                        fillMode: Image.PreserveAspectFit
                        visible: Utils.qualityBadge(playerOptions.quality)
                    }
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
            opacity: (!video.muted
                     && (volumeButton.containsMouse || ma.containsMouse)
                     && !qualityButton.checked) ? 1 : 0
            visible: opacity > 0
            Behavior on opacity { NumberAnimation { duration: 170 } }
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
            opacity: qualityButton.checked ? 1 : 0
            visible: opacity > 0
            Behavior on opacity { NumberAnimation { duration: 170 } }
            width: playerOptions.width + 10
            height: playerOptions.height + 10
            onVisibleChanged: if (!visible) playerOptions.pop()
            PlayerOptions {
                id: playerOptions
                anchors.centerIn: parent
                maxHeight: root.height - dockContainer.height - 30
                qualities: Utils.getQualities(info)
            }
        }
    }

    onInfoChanged: qualityButton.checked = false
    property var info: null
    property alias quality: playerOptions.quality
    property alias core: video
    property alias staysOnTop: staysOnTopButton.checked
    property alias detached: attachButton.checked
    property alias fullScreen: fullScreenButton.checked
}
