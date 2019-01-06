import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2

Label {
    id: locationDesc
    width: parent.width - 175
    text: qsTr('Change source location for news feed and YouTube trends.')
    font.weight: Font.Light
    textFormat: Text.RichText
    font.pixelSize: 12
    anchors.left: parent.left
    anchors.top: locationTitle.bottom
    anchors.leftMargin: 16
    anchors.topMargin: 2
    wrapMode: Text.WordWrap
}
