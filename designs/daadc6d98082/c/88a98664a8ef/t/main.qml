import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0

ListView {
    id: trendsList
    clip: true
    anchors.fill: parent
    anchors.margins: 10
    delegate: YouTubeTrendDelegate {}
    model: ListModel {}
    cacheBuffer: 9000
    onContentYChanged: {
        if (contentY < -100)
            refresh()
    }
    
    ScrollIndicator.vertical: ScrollIndicator { }
    
    signal refresh()
    signal videoOpened(var listElement)
}
