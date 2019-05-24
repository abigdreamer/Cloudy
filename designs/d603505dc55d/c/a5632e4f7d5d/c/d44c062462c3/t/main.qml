import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    id: city
    text: qsTr("Unknown")
    anchors.right: refresh.left
    anchors.left: updateGps.right
    anchors.top: parent.top
    anchors.topMargin: 8
    font.pixelSize: 20
    horizontalAlignment: Text.AlignHCenter
    wrapMode: Text.WordWrap
}
