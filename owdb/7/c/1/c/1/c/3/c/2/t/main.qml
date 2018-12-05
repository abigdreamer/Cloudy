import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    y: -159
    x: 31
    id: themeDesc
    width: parent.width - 160
    text: qsTr("Change application theme. Dark and Light themes are available for now.")
    font.weight: Font.Light
    font.pixelSize: 12
    anchors.left: parent.left
    anchors.top: themeTitle.bottom
    anchors.leftMargin: 16
    anchors.topMargin: 2
    wrapMode: Text.WordWrap
}
