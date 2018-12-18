import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0

ListView {
    id: trendsList
    clip: true
    anchors.fill: parent
    delegate: YouTubeTrendDelegate {}
    model: ListModel {}
    cacheBuffer: 9000
    onContentYChanged: {
        if (contentY < -100)
            refresh()
    }
    signal refresh()
    signal videoOpened(var listElement)
}
