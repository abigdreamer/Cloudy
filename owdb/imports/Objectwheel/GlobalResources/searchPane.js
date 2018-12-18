// searchPane.js

.import Application 1.0 as App
.import YouTubeInfo 1.0 as YouTubeInfo

function searchPane_onCompleted() {
    cleanSearchFieldButton.clicked.connect(cleanSearchFieldButton_onClicked)
    searchField.textEdited.connect(fetchSearchResults)
    videoSearchList.videoOpened.connect(videoSearchList_onVideoOpened)
    videoSearchList.loadMoreSearchResults.connect(videoSearchList_onLoadMoreComments)
}

function videoSearchList_onVideoOpened(listElement) {
    applicationWindow.videosBar.currentIndex = 2
    watchPane.video = listElement
}

function cleanSearchFieldButton_onClicked() {
    searchField.text = ""
    fetchSearchResults()
}

function videoSearchList_onLoadMoreComments() {
    fetchSearchResults(videoSearchList.nextPageToken)
}

function fetchSearchResults(nextPageToken) {    
    noResultLabel.visible = false
    busyIndicator.running = true
    videoSearchList.model.clear()
    
    App.Utils.suppressCall(1000, searchField, function() {
        var searchTerm = searchField.text
        var pageToken = videoSearchList.nextPageToken
        
        if (!nextPageToken)
            videoSearchList.model.clear()

        if (searchTerm === "") {
            busyIndicator.running = false
            noResultLabel.visible = true
            return
        }
        
        searchField.enabled = false

        YouTubeInfo.Fetch.getSearchResults(searchTerm, pageToken,
                                           function(value, npt, err) {        
            searchField.enabled = true
            busyIndicator.running = false
            videoSearchList.nextPageToken = npt
            if (err) {
                console.log(err)
                noResultLabel.visible = true
                return
            }
            for (var i = 0; i < value.length; ++i)
                videoSearchList.model.append(value[i])
            noResultLabel.visible = value.length === 0
        })
    })
}