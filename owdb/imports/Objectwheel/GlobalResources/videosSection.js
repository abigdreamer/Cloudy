// videosSection.js

function videosSection_onCompleted() {
    swipeView.addItem(trendsPane)
    swipeView.addItem(Qt.createQmlObject('import QtQuick 2.0;Item{}', swipeView))
    swipeView.addItem(watchPane)
}
