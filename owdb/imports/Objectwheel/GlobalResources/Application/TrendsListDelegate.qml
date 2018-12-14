import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0
import YouTube 1.0
import QtQuick.Window 2.2

Item {
    id: delegate
    height: 290
    width: ListView.view.width
    clip: true
    property var listView: ListView.view
    
    Image {
        id: banner
        source: imageUrl
        anchors.topMargin: 15
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 340
        height: 190
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Ready) {
                Fetch.getChannelImageUrl(channelId, function(val, err) {
                    if (err || !val) {
                        console.log(err)
                        return
                    }
                    channelImage.source = val
                })
            }
        }
    }
    
    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Settings.theme === 'Dark' ? "#404447" : "#e2e2e2"
        Behavior on color { SmoothColorAnimation {} }
    }
    
    RowLayout {
        clip: true
        anchors.left: banner.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.top: banner.bottom
        Item {
            width: 50
            height: 50
            Image {
                anchors.fill: parent
                clip: true
                visible: false
                id: channelImage
                fillMode: Image.PreserveAspectCrop
                sourceSize: Qt.size(60 * Screen.devicePixelRatio,
                                    60 * Screen.devicePixelRatio)
            }
            OpacityMask {
                anchors.fill: channelImage
                source: channelImage
                maskSource: Rectangle {
                    width: channelImage.width
                    height: channelImage.height
                    radius: channelImage.width
                }
            }
        }
        ColumnLayout {
            spacing: 0
            Layout.fillWidth: true
            Label {
                text: title
                wrapMode: Label.WordWrap
            }
            RowLayout {
                spacing: 0
                Label {
                    text: channelTitle + ' \u2022 '
                }
                Label {
                    text: Utils.viewString(statistics.viewCount) + ' \u2022 '
                }
                Label {
                    text: Utils.fromNow(date)
                }
            }
        }
    }
}
