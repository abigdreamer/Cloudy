import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    y: -157
    x: 10
    id: themeAccentDesc
    width: parent.width - 160
    text: qsTr("Choose whether the theme changing balloon (bubble head) should be shown or hid.")
    font.weight: Font.Light
    font.pixelSize: 12
    anchors.left: parent.left
    anchors.top: themeAccentTitle.bottom
    anchors.leftMargin: 16
    anchors.topMargin: 2
    wrapMode: Text.WordWrap
}
