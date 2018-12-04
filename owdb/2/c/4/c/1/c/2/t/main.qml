import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0
import Application.Resources 1.0
import QtGraphicalEffects 1.0

Item {
    id: tempMin
    clip: true
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: height/2.0
    anchors.rightMargin: 10
    width: 80
    height: 25

    Item {
        id: icon
        x: label.text.length >= tempMax.lbl.text.length ? (tempMin.width - label.width - width) : tempMax.icn.x
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
            source: Resource.images.other.arrowDown
            verticalAlignment: Image.AlignVCenter
        }
        ColorOverlay {
          anchors.fill: im
          source: im
          color: "#2196F3"
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

    Tip {
        anchors.fill: parent
        text: qsTr("Min temperature for the day")
    }
    
    property alias lbl: label
    property alias icn: icon
    property alias text: label.text
}