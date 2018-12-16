import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0

ListView {
    id: commentsList
    clip: true
    width: watchPane.width
    delegate: YouTubeCommentDelegate {}
    model: ListModel {}
}