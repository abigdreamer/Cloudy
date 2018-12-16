import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0

ListView {
    id: trendsList
    clip: true
    anchors.fill: parent
    delegate: YouTubeVideoDelegate {}
    model: ListModel {}
    onContentYChanged: {
        if (contentY < -100)
            refresh()
    }
    signal refresh()
    signal videoOpened(var modelData)
}
