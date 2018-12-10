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
    
    Tip {
        id: tip
        text: flowOn ? qsTr("News flow: On") : qsTr("News flow: Off")
        ToolTip.visible: show
        SequentialAnimation {
            id: anim
            NumberAnimation { target: tip; property: "show"; to: 1; duration: 100 }
            NumberAnimation { target: tip; property: "show"; to: 1; duration: 1000 }
            NumberAnimation { target: tip; property: "show"; to: 0; duration: 400 }
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
    onFlowOnChanged: tip.onOffAnim.running = true
    Component.onCompleted: flowOn = true
    property bool flowOn: false
}
