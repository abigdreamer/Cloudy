// trendsPane.js
.import YouTube 1.0 as YouTube
.import Application 1.0 as App

function trendsPane_onCompleted() {
    refreshButton.clicked.connect(refreshButton_onClicked)
}

function refreshButton_onClicked() {
    trendsPane.enabled = false
    busyIndicator.running = true
    trendsList.model.clear()
    
    YouTube.Fetch.getTrends(App.Settings.countryCode(), function(value, err) {
        trendsPane.enabled = true
        busyIndicator.running = false
        if (err) {
            console.log(err)
            return
        }
        for (var i = 0; i < value.length; ++i)
            trendsList.model.append(value[i])
    })
}
