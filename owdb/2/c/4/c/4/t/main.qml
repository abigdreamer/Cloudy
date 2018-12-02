import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    y: 103
    x: 2
    id: description
    text: "-"
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 8
    font.pixelSize: 18
    wrapMode: Text.WordWrap
    horizontalAlignment: Text.AlignHCenter
}