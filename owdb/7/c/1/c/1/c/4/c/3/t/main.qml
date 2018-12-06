import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    y: -157
    x: 10
    id: themeAccentDesc
    width: parent.width - 175
    text: qsTr('Choose the color tone that will add richness to the theme.')
    font.weight: Font.Light
    font.pixelSize: 12
    anchors.left: parent.left
    anchors.top: themeAccentTitle.bottom
    anchors.leftMargin: 16
    anchors.topMargin: 2
    wrapMode: Text.WordWrap
}
