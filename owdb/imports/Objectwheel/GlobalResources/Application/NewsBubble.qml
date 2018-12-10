import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Application 1.0
import Application.Resources 1.0
import QtGraphicalEffects 1.0

Item {
    x: parent.width / 2.0 - width / 2.0
    y: - height
    width: 70
    height: 70

    Image {
        id: image
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        source: news.imageUrl ? news.imageUrl : ""
        fillMode: Image.PreserveAspectCrop
        visible: false
    }
    
    Rectangle {
        id: imageMask
        anchors.fill: image
        visible: false
        radius: width / 2.0
    }

    OpacityMask {
        anchors.fill: image
        source: image
        maskSource: imageMask
        opacity: image.status == Image.Ready ? 1 : 0
        Behavior on opacity { NumberAnimation {} }
        Rectangle {
            visible: image.status == Image.Ready
            anchors.fill: parent
            border.width: 2.5
            border.color: Material.accent
            SmoothColorAnimation on border.color {}
            color: "transparent"
            radius: width / 2.0
        }        
    }
    
    MouseArea {
        anchors.fill: image
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        //onClicked: flowOn = !flowOn
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
    
    onXChanged: {
        if (parent.x > width / 2.0) {
            if (x < -width / 2.0)
                x = -width / 2.0
        } else {
            if (x < -parent.x)
                x = -parent.x
        }

        if (homePane.width - parent.x - parent.width > width / 2.0) {
            if (x > width / 2.0)
                x = width / 2.0
        } else {
            if (x > homePane.width - parent.x - parent.width)
                x = homePane.width - parent.x - parent.width
        }
    }
    
    function run() {
        iterateVerticalTimer.start()
        iterateHorizontalTimer.start()
        horzDirectionChangeTimer.start()
    }

    QtObject {
        id: d
        property bool horzDirection: Utils.getRandomInteger(0, 1)
        readonly property real minSpeed: 0.4
        readonly property real maxSpeed: Utils.getRandomNumber(minSpeed, 4.5)
        readonly property real vSpeed: Utils.getRandomNumber(minSpeed, maxSpeed)
        readonly property real hSpeed: Utils.getRandomNumber(minSpeed, maxSpeed)
        readonly property real directionChangeInterval: Utils.getRandomInteger(1500, 4000)
    }

    property var news: []
}
