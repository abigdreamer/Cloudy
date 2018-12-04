import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0
import Application.Resources 1.0

Button {
    id: refresh
    height: 36
    width: 30
    z: 1
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.topMargin: 3
    anchors.rightMargin: 8
    
    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        hoverEnabled: true
        onPressed: mouse.accepted = false
        ToolTip.visible: containsMouse
        ToolTip.text: qsTr("Refresh weather data")
        ToolTip.toolTip.y: -35
    }
        
    Image {
        source: Resource.images.other.refresh
        fillMode: Image.PreserveAspectFit
        width: 20
        height: 20
        anchors.centerIn: parent
        smooth: true
    }
    
    Tip {
        anchors.fill: parent
        text: qsTr("Refresh weather data")
    }
    Cursor {}
}
