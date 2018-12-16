// watchPane.js

.import YouTube 1.0 as YouTube
.import QtQuick.Controls 2.8 as QC

function watchPane_onCompleted() {
    watchPane.videoChanged.connect(watchPane_onVideoChanged)
}

function watchPane_onVideoChanged() {
    container.QC.ScrollBar.vertical.position = 0
    titleContainer.showDescription = false
    commentsBusyIndicator.running = true
    
    YouTube.Fetch.getComments(watchPane.video.id, function(value, err) {        
        commentsBusyIndicator.running = false
        commentsList.model.clear()
        if (err) {
            console.log(err)
            return
        }
        for (var i = 0; i < value.length; ++i)
            commentsList.model.append(value[i])
    })
}
