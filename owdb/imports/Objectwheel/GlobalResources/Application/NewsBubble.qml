import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Application 1.0
import Application.Resources 1.0
import QtGraphicalEffects 1.0

Item {
    id: root
    x: parent.width / 2.0 - width / 2.0
    y: - parent.height
    width: 70
    height: 70
    visible: opacity > 0
    Behavior on opacity { NumberAnimation { duration: 600 } }
    
    onXChanged: {
        if (parent.x > width / 2.0) {
            if (x < -width / 2.0)
                x = -width / 2.0
        } else {
            if (x < -parent.x)
                x = -parent.x
        }

        if (newsSection.width - parent.x - parent.width > width / 2.0) {
            if (x > width / 2.0)
                x = width / 2.0
        } else {
            if (x > newsSection.width - parent.x - parent.width)
                x = newsSection.width - parent.x - parent.width
        }
    }

    Image {
        id: image
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        source: news.imageUrl ? news.imageUrl : ""
        fillMode: Image.PreserveAspectCrop
        visible: false
        onStatusChanged: if (image.status == Image.Ready) root.opacity = 1
    }
    
    Rectangle {
        id: imageMask
        anchors.fill: image
        visible: false
        radius: width / 2.0
    }

    OpacityMask {
        id: opMask
        visible: false
        anchors.fill: image
        source: image
        maskSource: imageMask
        opacity: image.status == Image.Ready ? 1 : 0
        Behavior on opacity { NumberAnimation {} }
    }

    DropShadow {
        source: opMask
        anchors.fill: opMask
        horizontalOffset: 0
        verticalOffset: 3
        radius: 10
        samples: 15
        color: "#80000000"
        Rectangle {
            anchors.fill: parent
            border.width: 2.3
            border.color: Settings.theme == 'Dark'
                          ? "#50ffffff" : "#70000000"
            SmoothColorAnimation on border.color {}
            color: "transparent"
            radius: width / 2.0
            visible: image.status == Image.Ready
        }
    }
            
    Timer {
        id: iterateVerticalTimer
        interval: 50
        repeat: true
        running: false
        onTriggered: parent.y -= d.vSpeed
    }
    
    Timer {
        id: iterateHorizontalTimer
        interval: 50
        repeat: true
        running: false
        onTriggered: parent.x = d.horzDirection
                     ? parent.x + d.hSpeed
                     : parent.x - d.hSpeed
    }
    
    Timer {
        id: horzDirectionChangeTimer
        interval: d.directionChangeInterval
        repeat: true
        running: false
        onTriggered: d.horzDirection = Utils.getRandomInteger(0, 1)
    }
    
    Canvas {
        id: descBalloon
        anchors.right: image.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 250
        visible: false
        Label {
            id: title
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.rightMargin: 20
            anchors.topMargin: 6
            wrapMode: Label.WordWrap
            font.weight: Font.Medium
            text: news.title ? news.title : ""
            color: Settings.theme == 'Dark' ? "#272727" : "white"
            SmoothColorAnimation on color {}
            font.pixelSize: 13
            height: 15
            elide: Text.ElideRight
        }
        Label {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: title.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.rightMargin: 20
            anchors.topMargin: 2
            anchors.bottomMargin: 6
            wrapMode: Label.WordWrap
            font.weight: Font.Light
            text: news.description ? news.description : ""
            color: Settings.theme == 'Dark' ? "#111111" : "white"
            SmoothColorAnimation on color {}
            font.pixelSize: 11
            elide: Text.ElideRight
        }

        onPaint: drawRoundedRect(1, 1, width - 14, height - 2, 14)
        function drawRoundedRect(x, y, w, h, radius) {
            var context = getContext("2d")
            var r = x + w
            var b = y + h
            context.clearRect(0, 0, width, height);
            context.beginPath()
            context.fillStyle = "#6f6f6f"
            context.lineWidth = 2.3
            context.strokeStyle = Settings.theme == 'Dark'
                    ? "#35ffffff" : "#45000000"
            context.moveTo(x + radius, y)
            context.lineTo(r - radius, y)
            context.quadraticCurveTo(r, y, r, y + radius)
            context.quadraticCurveTo(r, y + h / 2.0, r + 12, y + h / 2.0)
            context.quadraticCurveTo(r, y + h / 2.0, r, y + h - h / 8.0)
            context.quadraticCurveTo(r, b, r - radius, b)
            context.lineTo(x + radius, b)
            context.quadraticCurveTo(x, b, x, b - radius)
            context.lineTo(x, y + radius)
            context.quadraticCurveTo(x, y, x + radius, y)
            context.moveTo(r, y + h / 8.0)
            context.fill()
            context.stroke()
        }
        Component.onCompleted: Settings.themeChanged.connect(requestPaint)
    }

    DropShadow {
        source: descBalloon
        anchors.fill: descBalloon
        horizontalOffset: 0
        verticalOffset: 3
        radius: 10
        samples: 15
        color: "#80000000"
        opacity: d.initiallyDescVisible || mouseArea.containsMouse ? 1 : 0
        Behavior on opacity
        { NumberAnimation { duration: d.initiallyDescVisible ? 600 : 100 } }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: image
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onContainsMouseChanged: {
            parent.z = containsMouse
            parent.parent.flowPaused = containsMouse
        }
        onClicked: parent.parent.showNews(news)
    }
    
    function play() {
        if (image.status == Image.Ready)
            opacity = 1
        iterateVerticalTimer.start()
        iterateHorizontalTimer.start()
        horzDirectionChangeTimer.start()
    }
    
    function pause() {
        iterateVerticalTimer.stop()
        iterateHorizontalTimer.stop()
        horzDirectionChangeTimer.stop()
    }

    function stop() {
        pause()
        opacity = 0
    }
    
    function resetPos() {
        y = - parent.height
    }

    QtObject {
        id: d
        property bool initiallyDescVisible: image.status == Image.Ready && root.y > -400
        property bool horzDirection: Utils.getRandomInteger(0, 1)
        readonly property real minSpeed: 0.4
        readonly property real maxSpeed: Utils.getRandomNumber(minSpeed, 3.0)
        readonly property real vSpeed: 1
        readonly property real hSpeed: Utils.getRandomNumber(minSpeed, maxSpeed)
        readonly property real directionChangeInterval: Utils.getRandomInteger(1500, 4000)
    }

    property var news: []
}
