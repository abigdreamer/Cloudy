import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0
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

    Image {
        source: Resource.images.other.gps
        fillMode: Image.PreserveAspectFit
        width: 20
        height: 20
        anchors.centerIn: parent
        smooth: true
    }
    Tip {
        anchors.fill: parent
        text: map.valid
            ? qsTr("Get weather information for your GPS location")
            : qsTr("Unable to connect to your GPS device")
        
    }
    Cursor {}
}