import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    id: title
    text: watchPane.video ? watchPane.video.title : "NaN"
    wrapMode: Label.WordWrap
    font.pixelSize: 15
    maximumLineCount: 2
    elide: Label.ElideRight
    anchors.right: arrowDown.left
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.topMargin: 15
    anchors.leftMargin: 15
    anchors.rightMargin: 4
}
