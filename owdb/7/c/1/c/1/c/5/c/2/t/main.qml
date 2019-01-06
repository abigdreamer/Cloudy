import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    y: 23
    x: 10
    id: themeAccentTitle
    width: parent.width - 150
    text: qsTr("Theme Accent")
    font.weight: Font.Light
    font.pixelSize: 24
    anchors.left: parent.left
    anchors.bottom: parent.verticalCenter
    anchors.leftMargin: 16
    anchors.bottomMargin: 4
}
