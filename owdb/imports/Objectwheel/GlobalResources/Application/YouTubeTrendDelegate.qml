import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0
import YouTubeInfo 1.0
import QtQuick.Window 2.2

ItemDelegate {
    id: delegate
    height: 290
    width: ListView.view.width
    clip: true
    property var listView: ListView.view
    
    Cursor {}
    
    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Settings.theme === 'Dark' ? "#404447" : "#e2e2e2"
        Behavior on color { SmoothColorAnimation {} }
    }

    Item {
        id: bannerContainer
        anchors.topMargin: 15
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 340
        height: 190
        Image {
            id: banner
            source: imageUrl
            anchors.fill: parent
            visible: false
            fillMode: Image.PreserveAspectCrop
            sourceSize: Qt.size(width * Screen.devicePixelRatio,
                                width * Screen.devicePixelRatio)
        }
        OpacityMask {
            anchors.fill: banner
            source: banner
            maskSource: Rectangle {
                width: banner.width
                height: banner.width
                radius: 3
            }
            Rectangle {
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 8
                color: "#a0000000"
                radius: 3
                width: durationText.width + 6
                height: durationText.height + 4
                Text {
                    id: durationText
                    anchors.centerIn: parent
                    text: Utils.toProperDurationString(duration)
                    color: "white"
                }
            }
        }
    }
    
    RowLayout {
        clip: true
        spacing: 10
        anchors.left: bannerContainer.left
        anchors.right: bannerContainer.right
        anchors.top: bannerContainer.bottom
        anchors.topMargin: 15
        
        Item {
            width: 48
            height: 48
            Layout.preferredWidth: 48
            Layout.preferredHeight: 48
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Image {
                id: channelImage
                anchors.fill: parent
                visible: false
                fillMode: Image.PreserveAspectCrop
                source: channelImageUrl
                sourceSize: Qt.size(width * Screen.devicePixelRatio,
                                    width * Screen.devicePixelRatio)
            }
            OpacityMask {
                anchors.fill: channelImage
                source: channelImage
                maskSource: Rectangle {
                    width: channelImage.width
                    height: channelImage.width
                    radius: channelImage.width
                }
            }
        }
        
        ColumnLayout {
            spacing: 4
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label {
                text: qsTr(title)
                wrapMode: Label.WordWrap
                Layout.fillWidth: true
                font.pixelSize: 15
                maximumLineCount: 2
                elide: Label.ElideRight
            }
            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                wrapMode: Label.WordWrap
                font.pixelSize: 13
                maximumLineCount: 2
                elide: Label.ElideRight
                verticalAlignment: Label.AlignTop
                color: Settings.theme === 'Dark' ? "#949494" : "#848484"
                Behavior on color { SmoothColorAnimation {} }
                text: channelTitle + ' \u2022 '
                + Utils.viewString(statistics.viewCount) + ' \u2022 '
                + Utils.fromNow(date)
            }
        }
    }
    
    onClicked: listView.videoOpened(listView.model.get(index))
}
