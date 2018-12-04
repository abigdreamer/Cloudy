import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0

Label {
    y: 24.5
    x: 222
    id: temp
    text: "NaN"
    clip: true
    height: 40
    width: 110
    anchors.right: parent.right
    anchors.bottom: tempMax.top
    anchors.rightMargin: 10
    font.pixelSize: 32
    horizontalAlignment: Text.AlignRight
    verticalAlignment: Text.AlignVCenter
    
    Tip {
        anchors.fill: parent
        text: qsTr("Temperature (last 3hr)")
    }
}