import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Application 1.0
import Application.Resources 1.0

AnimatedImage {
    id: newsBalloon
    x: 290
    y: 475
    width: 75
    height: 75
    source: Resource.images.other.newsOff
    playing: flowOn
    
    Drag.active: true
    Drag.hotSpot.x: width / 2.0
    Drag.hotSpot.y: height / 2.0

    onXChanged: {
        if (x < 0)
            x = 0
        else if (x > parent.width - width)
            x = parent.width - width
    }
    
    onYChanged: {
        if (y < 0)
            y = 0
        else if (y > parent.height - height)
            y = parent.height - height
    }
    
    Rectangle {
        id: onOffIndicator
        anchors.centerIn: parent
        width: 35
        height: 30
        radius: 12
        color: "#a0000000"
        opacity: 0
    
        SequentialAnimation {
            id: anim
            NumberAnimation { target: onOffIndicator; property: "opacity"; to: 1; duration: 100 }
            NumberAnimation { target: onOffIndicator; property: "opacity"; to: 1; duration: 1000 }
            NumberAnimation { target: onOffIndicator; property: "opacity"; to: 0; duration: 400 }
        }
        
        Label {
            color: "white"
            font.pixelSize: 16
            font.bold: true
            anchors.centerIn: parent
            text: flowOn ? qsTr("On") : qsTr("Off")
        }
        property alias onOffAnim: anim
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        drag.target: newsBalloon
        cursorShape: drag.active
                     ? Qt.ClosedHandCursor
                     : Qt.PointingHandCursor
        onClicked: flowOn = !flowOn
    }
    onFlowOnChanged: onOffIndicator.onOffAnim.running = true
    property bool flowOn: false
}
