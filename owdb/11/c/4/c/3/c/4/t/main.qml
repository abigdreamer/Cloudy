import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import Application 1.0
import Application.Resources 1.0

ListView {
    id: commentsList
    clip: true
    width: watchPane.width
    delegate: YouTubeCommentDelegate {}
    model: ListModel {}
    height: model.count === 0
            ? watchPane.height - channelContainer.height - titleContainer.height - player.height
            : contentHeight
    interactive: false
    header: Label {
        width: watchPane.width
        height: 30
        text: qsTr("Comments") + ' \u2022 '
              + (watchPane.video
                 ? Utils.likeString(watchPane.video.statistics.commentCount)
                 : 0)
        font.pixelSize: 15
        leftPadding: 15
        topPadding: 10
        
        Image {
            id: image
            source: Resource.images.other.options
            width: 20
            height: 20
            sourceSize: Qt.size(width * Screen.devicePixelRatio,
                                height * Screen.devicePixelRatio)
            fillMode: Image.PreserveAspectFit
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            Tip { anchors.fill: parent; text: qsTr("Order by") }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: optionsMenu.open()
            }
            Menu {
                id: optionsMenu
                x: parent.width - width
                transformOrigin: Menu.TopRight
                MenuItem {
                    id: ti
                    text: qsTr("Time")
                    autoExclusive: true
                    checkable: true
                    checked: false
                    icon.source: Resource.images.other.time
                    icon.color: "transparent"
                    Component.onCompleted: d.timeItem = ti
                    Cursor {}
                }
                MenuItem {
                    text: qsTr("Relevance")
                    autoExclusive: true
                    checkable: true
                    checked: true
                    icon.source: Resource.images.other.best
                    icon.color: "transparent"
                    Cursor {}
                }
            }
        }
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: backgroundClicked()
        z: -1
    }
    
    QtObject {
        id: d
        property var timeItem
    }

    property bool orderByTime: d.timeItem.checked
    signal backgroundClicked()
}