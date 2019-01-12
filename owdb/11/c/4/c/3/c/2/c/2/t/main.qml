import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    id: channelTitle
    text: watchPane.video
          ? watchPane.video.channelTitle
          : "NaN"
    wrapMode: Label.NoWrap
    elide: Text.ElideRight
    font.pixelSize: 15
    maximumLineCount: 1
    anchors.left: channelImage.right
    anchors.leftMargin: 10
    anchors.top: channelImage.top
    anchors.topMargin: 2
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: watchPane.openUserDialog()
    }
}
