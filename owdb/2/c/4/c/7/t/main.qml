import QtQuick 2.7
import QtQuick.Controls 2.2
import Application.Resources 1.0

Button {
    id: updateGps
    height: 36
    width: 30
    z: 1
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.topMargin: 3
    anchors.leftMargin: 8
    enabled: map.valid
    
    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        hoverEnabled: true
        onPressed: mouse.accepted = false
        ToolTip.visible: containsMouse
        ToolTip.text: updateGps.enabled
                      ? qsTr("Get weather information for your GPS location")
                      : qsTr("Your device do not support GPS tracking")
        ToolTip.toolTip.y: -35
    }
        
    Image {
        source: Resource.images.other.gps
        fillMode: Image.PreserveAspectFit
        width: 20
        height: 20
        anchors.centerIn: parent
        smooth: true
    }
}