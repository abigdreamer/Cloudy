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
}

function commentsList_onLoadMoreComments() {
    fetchComments(commentsList.nextPageToken)
}

function fetchComments(nextPageToken) {
    commentsBusyIndicator.running = true
    commentsList.enabled = false
    
    YouTubeInfo.Fetch.getComments(watchPane.video.id, commentsList.orderByTime, nextPageToken,
                              function(value, npt, err) {
        commentsList.enabled = true
        commentsBusyIndicator.running = false
        commentsList.nextPageToken = npt
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
