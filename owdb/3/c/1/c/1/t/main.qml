import QtQuick 2.8

Item {
    id: newsRiver
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.top
    width: 50
    height: newsBalloon.y - 10
    
    QtObject {
        id: d
        property var news: []
    }
    
    function start(news) {
        d.news = news
    }
}
