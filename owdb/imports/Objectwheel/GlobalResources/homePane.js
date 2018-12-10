// homePane.js

.import NewsInfo 1.0 as NewsInfo
.import Application 1.0 as App
.import QtQuick 2.0 as QQ

var news = []
var newsBubbles = []
var count = 0

function homePane_onCompleted() {
    newsBalloon.flowOnChanged.connect(newsBalloon_onFlowOnChanged)

}

function newsBalloon_onFlowOnChanged() {
    newsBalloon.enabled = false

    if (!newsBalloon.flowOn) {
        for (var i = 0; i < newsBubbles.length; ++i)
            newsBubbles[i].destroy()
        newsBubbles = []
        newsBalloon.enabled = true
        return
    }
    
    count += 1
    NewsInfo.Fetch.getTopNews('us', function(val, err) {
        newsBalloon.enabled = true
        if (err) {
            newsBalloon.flowOn = false
            console.log(err)
            return
        }
        news = val
        if (news.length > 0)
            moveToNextNews(0, count)
    })
}

function moveToNextNews(index, cnt) {
    if (!newsBalloon.flowOn)
        return
    
    if (count !== cnt)
        return
    
    if (news.length <= index)
        return
        
    var nextNews = news[index]
    var component = Qt.createComponent(Qt.resolvedUrl('./Application/NewsBubble.qml'))
    
    if (component.status !== QQ.Component.Ready)
        return console.trace()
    
    var newsBubble = component.createObject(newsBalloon)
    if (!newsBubble)
        return console.trace()
    newsBubbles.push(newsBubble)
    newsBubble.parent = newsBalloon
    newsBubble.news = nextNews
    newsBubble.run()
    
    if (news.length > index + 1) {
        App.Utils.delayCall(App.Utils.getRandomInteger(1500, 6000), homePane,
                            function() {
            moveToNextNews(index + 1, cnt)
        })
    }
}
