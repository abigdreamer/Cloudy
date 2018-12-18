import QtQuick 2.7
import QtQuick.Controls 2.8
import QtQuick.Controls.Material 2.2
import Objectwheel.GlobalResources 1.0
import QtQuick.Window 2.3
import Application 1.0
import QtGraphicalEffects 1.0

Page {
    id: watchPane
    width: 342
    height: 608
    Component.onCompleted: WatchPaneJS.watchPane_onCompleted()
    
    Dialog {
        id: userDialog
        modal: true
        focus: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 300
        height: 400
        Column {
            spacing: 10
            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 256
                height: 256
                Image {
                    id: userImage
                    anchors.fill: parent
                    sourceSize: Qt.size(width * Screen.devicePixelRatio,
                                        height * Screen.devicePixelRatio)
                    fillMode: Image.PreserveAspectFit
                    visible: false
                }
                OpacityMask {
                    source: userImage
                    anchors.fill: userImage
                    maskSource: Rectangle {
                        width: userImage.width
                        height: userImage.height
                        radius: 4
                    }
                    
                    BusyIndicator {
                        anchors.centerIn: parent
                        running: userImage.status === Image.Loading
                    }
                }
            }
            Button {
                id: moreButton
                text: qsTr("More details")
                width: 200
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: Qt.openUrlExternally(url)
                Material.theme: Material.Light
                Material.background: Material.accent
                Material.foreground: "white"
                property var url
                Cursor {}
            }
        }
    }
    
    function openUserDialog(listElement) {
        if (listElement) {
            userDialog.title = listElement.authorDisplayName
            userImage.source = listElement.authorProfileImageUrl.replace("s80-c", "s512-c")
            moreButton.url = listElement.authorChannelUrl
        } else {
            userDialog.title = watchPane.video.channelTitle
            userImage.source = watchPane.video.channelImageUrl
            moreButton.url = 'https://www.youtube.com/channel/%1'
                                        .arg(watchPane.video.channelId)
        }

        userDialog.open()
    }
    
    property var video
}
