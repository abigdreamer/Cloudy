// newsPane.js

.import NewsInfo 1.0 as NewsInfo
.import Application 1.0 as App
.import QtQuick 2.0 as QQ

var news = []
var newsIndex = 0
var newsBubbles = []

function newsPane_onCompleted() {
    newsBalloon.QQ.Component.completed.connect(newsBalloon_onCompleted)
    newsBalloon.showNews.connect(newsBalloon_onShowNews)
    newsBalloon.flowOnChanged.connect(newsBalloon_onFlowOnChanged)
    newsBalloon.flowPausedChanged.connect(newsBalloon_onFlowPausedChanged)
}

function newsBalloon_onCompleted() {
    App.Utils.repeatedlyCall(60000, newsPane, updateNews)
    App.Utils.repeatedlyCall(4000, newsPane, showNextBubble)
    
    updateNews()
    createBubbles(newsBalloon)
    newsBalloon_onFlowOnChanged()
}

function updateNews() {
    NewsInfo.Fetch.getTopNews("us", function(val, err) {
        if (err) {
            console.log(err)
            return
        }
        news = val
    })
}

function createBubbles(parent) {
    for (var i = 0; i < 10; ++i)
        newsBubbles.push(createBubble(parent))
}

function createBubble(parent) {
    var component = Qt.createComponent(Qt.resolvedUrl('./Application/NewsBubble.qml'),
                                       QQ.Component.PreferSynchronous, parent)
    if (component.status !== QQ.Component.Ready)
        return console.trace()
    
    var newsBubble = component.createObject(parent)
    if (!newsBubble)
        return console.trace()
    newsBubble.stop()
    return newsBubble
}

function newsBalloon_onFlowOnChanged() {
    if (newsBalloon.flowPaused)
        return
    for (var i = 0; i < newsBubbles.length; ++i) {
        if (newsBalloon.flowOn)
            newsBubbles[i].play()
        else
            newsBubbles[i].stop()
    }
}

function newsBalloon_onFlowPausedChanged() {
    if (!newsBalloon.flowOn)
        return
    for (var i = 0; i < newsBubbles.length; ++i) {
        if (newsBalloon.flowPaused)
            newsBubbles[i].pause()
        else
            newsBubbles[i].play()
    }
}

function showNextBubble() {
    if (newsBalloon.flowPaused)
        return
    
    if (!newsBalloon.flowOn)
        return
    
    if (news.length === 0)
        return
    
    if (news.length < newsIndex)
        newsIndex = 0
    
    var nextNews = news[newsIndex]
    if (!nextNews || typeof nextNews === "undefined") {
        newsIndex = 0
        return
    }
    
    var bubble = newsBubbles.shift()
    bubble.news = nextNews
    bubble.resetPos()
    bubble.play()
    newsBubbles.push(bubble)
    newsIndex++
}

function newsBalloon_onShowNews(news) {
    newsPane.news = news
    newsPane.newsDialog.open()
    App.Utils.delayCall(100, newsPane, () => newsBalloon.flowPaused = true)
}
