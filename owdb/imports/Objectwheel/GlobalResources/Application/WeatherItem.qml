import QtQuick 2.9
import QtQuick.Controls 2.3

Item {
    clip: true
    Image {
        id: im
        smooth: true
        width: height
        sourceSize: Qt.size(height, height)
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        verticalAlignment: Image.AlignVCenter
    }

    Label {
        id: label
        text: "NaN"
        font.pixelSize: 13
        anchors.left: im.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        ToolTip.visible: containsMouse
        ToolTip.text: tip
        ToolTip.toolTip.y: -35
    }

    property string tip: ""
    property alias iconSource: im.source
    property alias text: label.text
}