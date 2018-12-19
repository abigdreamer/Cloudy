import QtQuick 2.9
import QtQuick.Controls 2.3
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
    
    ScrollBar.horizontal: ScrollBar
    { policy: ScrollBar.AlwaysOff }
    ScrollBar.vertical: ScrollBar
    { policy: ScrollBar.AsNeeded; interactive: false }
    
    signal refresh()
    signal videoOpened(var listElement)
}
