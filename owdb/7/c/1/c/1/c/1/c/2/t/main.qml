import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    y: 12
    x: 15
    id: langDesc
    width: parent.width - 175
    text: qsTr('Change overall application language. Automatic option has taken from your system settings.')
    font.weight: Font.Light
    font.pixelSize: 12
    anchors.left: parent.left
    anchors.top: langTitle.bottom
    anchors.leftMargin: 16
    anchors.topMargin: 2
    wrapMode: Text.WordWrap
}
