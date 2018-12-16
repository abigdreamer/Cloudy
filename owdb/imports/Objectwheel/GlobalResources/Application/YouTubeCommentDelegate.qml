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
    height: column.height + 20
    width: ListView.view.width
    clip: true
    property var listView: ListView.view
    
    Component.onCompleted: listView.backgroundClicked.connect(deselect)

    function deselect() {
        displayText.deselect()
        authorText.deselect()
    }

    Rectangle {
        height: 1
        anchors.left: channelImage.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        color: Settings.theme === 'Dark' ? "#cc404447" : "#cce2e2e2"
        Behavior on color { SmoothColorAnimation {} }
        visible: index < listView.model.count - 1
    }
    
    Item {
        id: channelImage
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 15
        anchors.topMargin: 10
        width: 40
        height: 40
        Image {
            id: image
            anchors.fill: parent
            visible: false
            fillMode: Image.PreserveAspectCrop
            source: authorProfileImageUrl
            sourceSize: Qt.size(width * Screen.devicePixelRatio,
                                width * Screen.devicePixelRatio)
        }
        OpacityMask {
            anchors.fill: image
            source: image
            maskSource: Rectangle {
                width: image.width
                height: image.width
                radius: image.width
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: watchPane.openUserDialog(listView.model.get(index))
            }
        }
    }
    
    Column {
        id: column
        spacing: 6
        anchors.left: channelImage.right
        anchors.leftMargin: 10
        anchors.top: channelImage.top
        TextArea {
            id: displayText
            text: textDisplay
            wrapMode: Label.WordWrap
            width: delegate.width - column.x - 15
            font.pixelSize: 13
            height: lineCount < 5 ? paintedHeight + 5 : 60
            background: Item { }
            readOnly: true
            clip: true
            selectByMouse: true
            leftPadding: 0
            topPadding: 0
            rightPadding: 0
            bottomPadding: 0
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.IBeamCursor
                onPressed: {
                    mouse.accepted = false
                    listView.backgroundClicked()
                }
            }
        }
        TextArea {
            id: authorText
            width: delegate.width - column.x - 15
            wrapMode: Label.NoWrap
            font.pixelSize: 12
            height: 13
            color: Settings.theme === 'Dark' ? "#949494" : "#848484"
            Behavior on color { SmoothColorAnimation {} }
            text: authorDisplayName + ' \u2022 '
            + (updatedAt.getTime() !== publishedAt.getTime()
               ? qsTr("Updated ") + Utils.fromNow(updatedAt)
               : Utils.fromNow(publishedAt))
            background: Item {}
            readOnly: true
            clip: true
            selectByMouse: true
            leftPadding: 0
            topPadding: 0
            rightPadding: 0
            bottomPadding: 0
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.IBeamCursor
                onPressed: {
                    mouse.accepted = false
                    listView.backgroundClicked()
                }
            }
        }
        Item {
            clip: true
            height: 16
            width: 120
            Row {
                x: 0
                y: 0
                spacing: 3
                TintImage {
                    width: 16
                    height: 16
                    anchors.verticalCenter: parent.verticalCenter
                    icon.source: Resource.images.other.comments
                    tintColor: Settings.theme === 'Dark' ? "#949494" : "#848484"
                    Behavior on tintColor { SmoothColorAnimation {} }
                }
                Label {
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                    text: Utils.likeString(totalReplyCount)
                    color: Settings.theme === 'Dark' ? "#949494" : "#848484"
                    Behavior on color { SmoothColorAnimation {} }
                }
            }
            Row {
                x: 60
                y: 1
                spacing: 3
                TintImage {
                    width: 14
                    height: 14
                    anchors.verticalCenter: parent.verticalCenter
                    icon.source: Resource.images.other.like
                    tintColor: Settings.theme === 'Dark' ? "#949494" : "#848484"
                    Behavior on tintColor { SmoothColorAnimation {} }
                }
                Label {
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                    text: Utils.likeString(likeCount)
                    color: Settings.theme === 'Dark' ? "#949494" : "#848484"
                    Behavior on color { SmoothColorAnimation {} }
                }
            }
        }
    }
}
