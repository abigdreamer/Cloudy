import QtQuick 2.9
import Application 1.0

ListView {
    id: videoSearchList
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: searchField.bottom
    anchors.bottom: parent.bottom
    anchors.topMargin: 10
    delegate: YouTubeSearchDelegate {}
    model: ListModel {}
}
