import QtQuick 2.9
import QtQuick.Controls 2.3
import Application.Resources 1.0
import QtGraphicalEffects 1.0

Item {
    id: tempMax
    clip: true
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: -height/2.0
    anchors.rightMargin: 10
    width: 80
    height: 25

    Item {
        id: icon
        x: label.text.length >= tempMin.lbl.text.length ? (tempMax.width - label.width - width) : tempMin.icn.x
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: height
        Image {
            id: im
            smooth: true
            visible: false
            anchors.fill: parent
            anchors.margins: 3
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(height, height)
            source: Resource.images.other.arrowUp
            verticalAlignment: Image.AlignVCenter
        }
        ColorOverlay {
          anchors.fill: im
          source: im
          color: "#EA3936"
        }
    }
    
    Label {
        id: label
        text: "NaN"
        font.pixelSize: 13
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        ToolTip.visible: containsMouse
        ToolTip.text: qsTr("Max temperature for the day")
        ToolTip.toolTip.y: -35
    }

    property alias lbl: label
    property alias icn: icon
    property alias text: label.text
}