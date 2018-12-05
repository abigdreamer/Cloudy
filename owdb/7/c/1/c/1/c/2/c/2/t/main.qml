import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    y: 12
    x: 15
    id: measurementDesc
    width: parent.width - 160
    text: qsTr("Change current measurement system used by application to represent information.")
    font.weight: Font.Light
    font.pixelSize: 12
    anchors.left: parent.left
    anchors.top: measurementTitle.bottom
    anchors.leftMargin: 16
    anchors.topMargin: 2
    wrapMode: Text.WordWrap
}
