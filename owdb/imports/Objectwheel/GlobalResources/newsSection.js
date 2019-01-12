// newsSection.js

.import NewsInfo 1.0 as NewsInfo
.import Application 1.0 as App
.import QtQuick 2.0 as QQ

function newsSection_onCompleted() {
    newsBalloon.QQ.Component.completed.connect(newsBalloon_onCompleted)
    newsBalloon.showNews.connect(newsBalloon_onShowNews)
    newsBalloon.flowOnChanged.connect(newsBalloon_onFlowOnChanged)
    newsBalloon.flowPausedChanged.connect(newsBalloon_onFlowPausedChanged)
}

function newsBalloon_onCompleted() {
    App.Utils.repeatedlyCall(60000, newsSection, updateNews)
    App.Utils.repeatedlyCall(4000, newsSection, showNextBubble)
    
    updateNews()
    createBubbles(newsBalloon)
    newsBalloon_onFlowOnChanged()
}

function updateNews() {
    NewsInfo.Fetch.getTopNews(App.Settings.countrySettingToCode(App.Settings.location),
                              function(val, err) {
        if (err) {
            console.log(err)
            return
        }
        newsSection.news = val
    })
}

function createBubbles(parent) {
    for (var i = 0; i < 10; ++i)
        newsSection.newsBubbles.push(createBubble(parent))
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
    for (var i = 0; i < newsSection.newsBubbles.length; ++i) {
        if (newsBalloon.flowOn)
            newsSection.newsBubbles[i].play()
        else
            newsSection.newsBubbles[i].stop()
    }
}

function newsBalloon_onFlowPausedChanged() {
    if (!newsBalloon.flowOn)
        return
    for (var i = 0; i < newsSection.newsBubbles.length; ++i) {
        if (newsBalloon.flowPaused)
            newsSection.newsBubbles[i].pause()
        else
            newsSection.newsBubbles[i].play()
    }
}

function showNextBubble() {
    if (newsBalloon.flowPaused)
        return
    
    if (!newsBalloon.flowOn)
        return
    
    if (newsSection.news.length === 0)
        return
    
    if (newsSection.news.length < newsSection.newsIndex)
        newsSection.newsIndex = 0
    
    var nextNews = newsSection.news[newsSection.newsIndex]
    if (!nextNews || typeof nextNews === "undefined") {
        newsSection.newsIndex = 0
        return
    }
    
    var bubble = newsSection.newsBubbles.shift()
    bubble.news = nextNews
    bubble.resetPos()
    bubble.play()
    newsSection.newsBubbles.push(bubble)
    newsSection.newsIndex++
}

function newsBalloon_onShowNews(news) {
    newsSection.dialogNews = news
    newsSection.newsDialog.open()
    App.Utils.delayCall(100, newsSection, () => newsBalloon.flowPaused = true)
}
