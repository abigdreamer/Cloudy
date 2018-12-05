import QtQuick 2.8
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
        
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        drag.target: nightDarkModeBalloon
        cursorShape: drag.active
                     ? Qt.ClosedHandCursor
                     : Qt.PointingHandCursor
        onClicked: Settings.theme = Settings.theme === 'Dark'
                ? 'Light' : 'Dark'
    }
}
