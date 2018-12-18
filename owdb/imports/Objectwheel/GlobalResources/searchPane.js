// searchPane.js

.import Application 1.0 as App
.import YouTubeInfo 1.0 as YouTubeInfo

function searchPane_onCompleted() {
    searchField.textEdited.connect(searchField_onTextEdited)
    cleanSearchFieldButton.clicked.connect(cleanSearchFieldButton_onClicked)
    videoSearchList.videoOpened.connect(videoSearchList_onVideoOpened)
    videoSearchList.loadMoreSearchResults.connect(videoSearchList_onLoadMoreSearchResults)
}

function videoSearchList_onVideoOpened(listElement) {
    applicationWindow.videosBar.currentIndex = 2
    watchPane.video = listElement
}

function searchField_onTextEdited() {
    fetchSearchResults()
}

function cleanSearchFieldButton_onClicked() {
    searchField.text = ""
    fetchSearchResults()
}

function videoSearchList_onLoadMoreSearchResults() {
    var npt = videoSearchList.nextPageToken
    if (npt && typeof npt !== "undefined")
        fetchSearchResults(npt)
    else console.trace()
}

function fetchSearchResults(nextPageToken) {    
    noResultLabel.visible = false
    busyIndicator.running = true
    
    if (!nextPageToken)
        videoSearchList.model.clear()
    
    App.Utils.suppressCall(1000, searchField, function() {
        var searchTerm = searchField.text
        
        if (!nextPageToken)
            videoSearchList.model.clear()

        if (searchTerm === "") {
            busyIndicator.running = false
            noResultLabel.visible = true
            return
        }
        
        searchField.enabled = false

        YouTubeInfo.Fetch.getSearchResults(searchTerm, nextPageToken,
                                           function(value, npt, err) {        
            searchField.enabled = true
            busyIndicator.running = false
                                               
            if (npt && typeof npt !== "undefined")
                videoSearchList.nextPageToken = npt
            else
                videoSearchList.nextPageToken = null
        
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