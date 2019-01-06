import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtMultimedia 5.9
import Application 1.0
import Application.Resources 1.0
import QtQuick.Window 2.3

Rectangle {
    id: root
    color: "black"
    focus: true

    Keys.onSpacePressed: playButton.clicked()
    Keys.onLeftPressed: {
        video.seek(video.position - 15000)
        if (playerOptions.speed !== "Normal")
            audio.seek(video.position - 15000)
    }
    Keys.onRightPressed: {
        video.seek(video.position + 15000)
        if (playerOptions.speed !== "Normal")
            audio.seek(video.position + 15000)
    }
    Keys.onEscapePressed: if(fullScreenButton.checked) fullScreenButton.checked = false

    Component.onCompleted: watchPane.videoChanged.connect(function() {
        video.pause()
        playerBusyIndicator.running = true
    })

    onInfoChanged: {
        qualityButton.checked = false
        playerOptions.qualities = Utils.getQualities(info)
        if (playerOptions.quality === "" 
                || !playerOptions.qualities.includes(playerOptions.quality)) {
            playerOptions.quality = Utils.defaultVideoQuality(playerOptions.qualities)
        }
        if (playerOptions.quality !== "" && info.length > 0) {
            video.source = Utils.getVideo(info, playerOptions.quality).url
            video.play()
        }
    }

    Video {
        id: video
        anchors.fill: parent
        autoLoad: true
        autoPlay: true
        notifyInterval: 100
        onPlaybackRateChanged: qualityButton.checked = false
        onPlaybackStateChanged: qualityButton.checked = false

        Timer {
            repeat: true
            interval: 500
            running: true
            onTriggered: {
                if (!watchPane.video || typeof watchPane.video == "undefined")
                    return
                playerSlider.value
                    = video.position / Utils.toDurationMs(watchPane.video.duration)
                leftDuration.text =
                    '<pre>' + Utils.durationMsToString(video.position) + '</pre>'
            }
        }

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
            if (playbackState === MediaPlayer.PausedState
                    && playerSlider.value === 1)
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
        autoLoad: true
        autoPlay: false
        muted: video.muted || !buffered || blockSound
        volume: video.volume
        notifyInterval: 100
        playbackRate: video.playbackRate
        source: info.length > 0 ? Utils.getAudio(info).url : ""
        onSourceChanged: {
            buffered = false
            if (audio.playbackState !== MediaPlayer.PausedState)
                audio.pause()
        }
        Component.onCompleted: {
            video.playbackStateChanged.connect(function() {
                if (!buffered)
                    return
                if (video.playerState() === 'playing') {
                    if (audio.playbackState !== MediaPlayer.PlayingState)
                        audio.play()
                } else if (video.playerState() === 'paused') {
                    if (audio.playbackState !== MediaPlayer.PausedState)
                        audio.pause()
                } else if (video.playerState() === 'stopped') {
                    if (audio.playbackState !== MediaPlayer.StoppedState)
                        audio.stop()
                }
            })
            video.positionChanged.connect(function() {
                if (!buffered)
                    return
                if (playerOptions.speed !== "Normal")
                    return
                if (Math.abs(audio.position - video.position) > 250) {
                    blockSound = true
                    audio.seek(video.position)
                    Utils.suppressCall(500, audio, () => blockSound = false)
                }
            })
            video.statusChanged.connect(function() {
                if (video.status === MediaPlayer.Buffered) {
                    buffered = true
                    audio.seek(video.position)
                    if (video.playerState() === 'playing')
                        audio.play()
                } else {
                    buffered = false
                    if (audio.playbackState !== MediaPlayer.PausedState)
                        audio.pause()
                }
            })
        }
        onBlockSoundChanged: if (buffered) playerBusyIndicator.running = blockSound
        onBufferedChanged: playerBusyIndicator.running = !buffered

        property bool blockSound: false
        property bool buffered: false
    }
    
    BusyIndicator {
        id: playerBusyIndicator
        height: 50
        width: 50
        anchors.centerIn: parent
        Material.accent: "white"
        running: false
    }

    Rectangle {
        id: playPauseCircle
        anchors.centerIn: parent
        radius: height / 2
        color: "black"
        visible: opacity > 0
        opacity: 0
        width: 80
        height: 80
        scale: 0.2
        SequentialAnimation {
            id: animatePlayPause
            PropertyAction {
                target: playPauseCircle
                property: "opacity"
                value: 1
            }
            PropertyAction {
                target: playPauseCircle
                property: "scale"
                value: 0.2
            }
            ParallelAnimation {
                NumberAnimation {
                    target: playPauseCircle
                    duration: 1000
                    property: "opacity"
                    to: 0
                    easing.type: Easing.OutSine
                }
                NumberAnimation {
                    target: playPauseCircle
                    duration: 1000
                    property: "scale"
                    to: 1
                    easing.type: Easing.OutSine
                }
            }
        }
        TintImage {
            anchors.centerIn: parent
            width: 38
            height: 38
            icon.source:  {
                if (video.playerState() === 'playing')
                    return Resource.images.player.play
                return Resource.images.player.pause
            }
            tintColor: "white"
        }
        Component.onCompleted: video.playbackStateChanged.connect(function() {
            Utils.suppressCall(100, playPauseCircle, function() {
                if (!playerBusyIndicator.running)
                    animatePlayPause.restart()
            })
        })
    }

    Dock {
        id: dock
        videoPlayer: video
        audioPlayer: audio
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
                    Cursor {
                        onContainsMouseChanged: fullScreenContainer.containsMouse = containsMouse
                    }
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
                    Cursor {
                        onContainsMouseChanged: fullScreenContainer.containsMouse = containsMouse
                    }
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
                    Cursor {
                        onContainsMouseChanged: staysOnTopContainer.containsMouse = containsMouse
                    }
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
                        id: draggerArea
                        anchors.fill: parent
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
                    Cursor {
                        cursorShape: draggerArea.pressed
                                     ? Qt.ClosedHandCursor
                                     : Qt.PointingHandCursor
                        onContainsMouseChanged: staysOnTopContainer.containsMouse = containsMouse
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
                    Cursor {
                        onContainsMouseChanged: dockContainer.containsMouse = containsMouse
                    }
                    onClicked: {
                        video.seek(video.position - 15000)
                        if (playerOptions.speed !== "Normal")
                            audio.seek(video.position - 15000)
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
                    Cursor {
                        onContainsMouseChanged: dockContainer.containsMouse = containsMouse
                    }
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
                    Cursor {
                        onContainsMouseChanged: dockContainer.containsMouse = containsMouse
                    }
                    onClicked: {
                        qualityButton.checked = false
                        video.seek(video.position + 15000)
                        if (playerOptions.speed !== "Normal")
                            audio.seek(video.position + 15000)
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
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: Math.max(30, contentWidth)
                    horizontalAlignment: Text.AlignHCenter
                    maximumLineCount: 1
                    textFormat: Text.RichText
                    text: "<pre>--:--</pre>"
                    color: enabled ? "white" : "#707070"
                    Cursor {
                        cursorShape: Qt.ArrowCursor
                        onContainsMouseChanged: dockContainer.containsMouse = containsMouse
                    }
                }
                PlayerSlider {
                    id: playerSlider
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.preferredHeight: 12
                    from: 0.0
                    to: 1.0
                    onValueChanged: {
                        if (value === 1.0)
                            video.pause()
                    }
                    onMoved: {
                        video.seek(value * Utils.toDurationMs(watchPane.video.duration))
                        if (playerOptions.speed !== "Normal")
                            audio.seek(value * Utils.toDurationMs(watchPane.video.duration))
                        qualityButton.checked = false
                    }
                    Cursor {
                        onContainsMouseChanged: dockContainer.containsMouse = containsMouse
                    }
                }
                Text {
                    id: rightDuration
                    Layout.preferredWidth: Math.max(30, contentWidth)
                    Layout.alignment: Qt.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    maximumLineCount: 1
                    textFormat: Text.RichText
                    text: !watchPane.video || typeof watchPane.video === "undefined"
                          ? "<pre>--:--</pre>"
                          : '<pre>' + Utils.durationMsToString(Utils.toDurationMs(watchPane.video.duration)) + '</pre>'
                    color: enabled ? "white" : "#707070"
                    Cursor {
                        cursorShape: Qt.ArrowCursor
                        onContainsMouseChanged: dockContainer.containsMouse = containsMouse
                    }
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
                        onContainsMouseChanged: dockContainer.containsMouse = containsMouse
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
                    Cursor {
                        onContainsMouseChanged: dockContainer.containsMouse = containsMouse
                    }
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
            containsMouse: visible
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
                onQualityChanged: { 
                    if (quality !== "" && info.length > 0) {
                        var videoPos = video.position
                        var wasPlaying = video.playerState() === 'playing'
                        video.pause()
                        video.source = Utils.getVideo(info, quality).url
                        video.seek(videoPos)
                        if (playerOptions.speed !== "Normal")
                            audio.seek(videoPos)
                        video.playbackRate = Utils.toPlaybackRate(playerOptions.speed)
                        if (wasPlaying)
                            video.play()
                        else
                            video.pause()
                    }
                }
                onSpeedChanged: video.playbackRate = Utils.toPlaybackRate(playerOptions.speed)
            }
            containsMouse: visible
        }
    }

    property var info: null
    property alias quality: playerOptions.quality
    property alias staysOnTop: staysOnTopButton.checked
    property alias detached: attachButton.checked
    property alias fullScreen: fullScreenButton.checked
}
