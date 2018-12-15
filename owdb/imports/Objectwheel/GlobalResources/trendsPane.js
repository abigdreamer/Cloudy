// trendsPane.js
.import QtQuick 2.0 as QQ
.import YouTube 1.0 as YouTube
.import Application 1.0 as App

function trendsPane_onCompleted() {
    trendsList.refresh.connect(trendsList_onRefresh)
}

function trendsList_onRefresh() {
    trendsPane.enabled = false
    busyIndicator.running = true
    
    YouTube.Fetch.getTrends(App.Settings.countryCode(), function(value, err) {
        trendsPane.enabled = true
        busyIndicator.running = false
        trendsList.model.clear()
        if (err) {
            console.log(err)
            return
        }
        for (var i = 0; i < value.length; ++i)
            trendsList.model.append(value[i])
    })
}
