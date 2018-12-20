// watchPane.js

.import YouTubeInfo 1.0 as YouTubeInfo
.import QtQuick.Controls 2.8 as QC

function watchPane_onCompleted() {
    commentsList.orderByTimeChanged.connect(fetchComments)
    watchPane.videoChanged.connect(watchPane_onVideoChanged)
    commentsList.loadMoreComments.connect(commentsList_onLoadMoreComments)
}

function watchPane_onVideoChanged() {
    container.QC.ScrollBar.vertical.position = 0
    titleContainer.showDescription = false
    fetchComments()
    fetchVideoInfo()
}

function commentsList_onLoadMoreComments() {
    var npt = commentsList.nextPageToken
    if (npt && typeof npt !== "undefined")
        fetchComments(npt)
    else console.trace()
}

function fetchComments(nextPageToken) {
    if (!watchPane.video
            || typeof watchPane.video === "undefined") {
        return
    }

    commentsBusyIndicator.running = true
    commentsList.enabled = false
    
    YouTubeInfo.Fetch.getComments(watchPane.video.id, commentsList.orderByTime, nextPageToken,
                              function(value, npt, err) {
        commentsList.enabled = true
        commentsBusyIndicator.running = false
        if (npt && typeof npt !== "undefined")
            commentsList.nextPageToken = npt
        else
            commentsList.nextPageToken = null
        
        if (!nextPageToken)
            commentsList.model.clear()
        if (err) {
            console.log(err)
            return
        }
        for (var i = 0; i < value.length; ++i)
            commentsList.model.append(value[i])
    })
}

function fetchVideoInfo() {
    if (!watchPane.video
            || typeof watchPane.video === "undefined") {
        return
    }
    
    playerBusyIndicator.running = true
    player.enabled = false
    
    YouTubeInfo.Fetch.getVideoInfo(watchPane.video.id, function(value, err) {
        player.enabled = true
        playerBusyIndicator.running = false

        if (err) {
            player.videos = {}
            player.audioUrl = ""
            console.log(err)
            return
        }
        
        player.videos = toVideoUrls(value)
        player.audioUrl = toAudioUrl(value)
    })
}

function toVideoUrls(response) {
    var videos = {}
    for (var i = 0; i < response.length; ++i) {
        var video = response[i]
        if (video.ext !== "mp4")
            continue
        if (video.format.match(/\d+p/g))
            videos[video.format] = video.url
    }
    return videos
}

function toAudioUrl(response) {
    for (var i = 0; i < response.length; ++i) {
        var audio = response[i]
        if (audio.format.match(/[a|A]udio/g))
            return audio.url
    }
}
