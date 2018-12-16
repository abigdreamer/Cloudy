import QtQuick 2.9
import QtQuick.Controls 2.3
import Application.Resources 1.0
import QtQuick.Window 2.3
import Application 1.0

Item {
    id: sub
    anchors.right: parent.right
    anchors.verticalCenter: channelImage.verticalCenter
    anchors.rightMargin: 10
    width: row.width
    height: row.height
    Row {
        id: row
        spacing: 3
        Image {
            source: Resource.images.other.playButton
            width: 17
            height: 17
            sourceSize: Qt.size(width * Screen.devicePixelRatio,
                                height * Screen.devicePixelRatio)
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Image.AlignVCenter
            fillMode: Image.PreserveAspectFit
        }
        Label {
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("SUBSCRIBE")
            color: "#F11020"
            font.weight: Font.Normal
            font.pixelSize: 14
        }
    }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Qt.openUrlExternally('https://www.youtube.com/channel/%1?sub_confirmation=1'
                                        .arg(watchPane.video.channelId))
    }
}
