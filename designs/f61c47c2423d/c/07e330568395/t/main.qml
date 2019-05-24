import QtQuick 2.8
import QtQuick.Controls 2.2
import Application 1.0
import Application.Resources 1.0

Image {
    id: nightDarkModeBalloon
    z: 2
    x: 5
    y: 475
    width: 75
    height: 75
    opacity: Settings.themeBalloonVisible ? 1 : 0
    visible: opacity > 0
    
    Behavior on opacity { PropertyAnimation {} }

    source: Settings.theme === 'Dark'
                        ? Resource.images.other.light
                        : Resource.images.other.dark
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
        text: qsTr("Theme: ") + qsTr(Settings.theme)
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
        drag.target: nightDarkModeBalloon
        cursorShape: drag.active
                     ? Qt.ClosedHandCursor
                     : Qt.PointingHandCursor
        onClicked: {
            Settings.theme = Settings.theme === 'Dark'
                ? 'Light' : 'Dark'
            tip.onOffAnim.running = true
        }
    }
}
