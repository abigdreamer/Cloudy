// watchPane.js

function watchPane_onCompleted() {
    watchPane.videoChanged.connect(watchPane_onVideoChanged)
}

function watchPane_onVideoChanged() {
    // Do something...
}
