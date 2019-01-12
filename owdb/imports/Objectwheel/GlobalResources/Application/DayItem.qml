import QtQuick 2.8
import QtQuick.Controls 2.2
import Application 1.0
import Application.Resources 1.0
import QtGraphicalEffects 1.0

Item {
    clip: true
    
    Label {
        id: day
        text: qsTr("Day")
        font.pixelSize: 13
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    
    Image {
        id: icon
        smooth: true
        width: 55; height: 55
        anchors.centerIn: parent
        sourceSize: Qt.size(55, 55)
        fillMode: Image.PreserveAspectFit
        source: Resource.images.weatherCondition["01d"]        
    }
    
    Label {
        id: temp
        clip: true
        text: "NaN"
        font.pixelSize: 13
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Tip {
        anchors.fill: parent
        text: description
    }
    
    property string description: ""
    property alias icon: icon.source
    property alias day: day.text
    property alias temp: temp.text
}
