import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0

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
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: backgroundClicked()
        z: -1
    }

    signal backgroundClicked()
}