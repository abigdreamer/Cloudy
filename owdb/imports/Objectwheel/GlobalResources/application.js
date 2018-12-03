// application.js

function application_onCompleted() {
    swipeView.currentIndexChanged.connect(swipeView_onCurrentIndexChanged)
    swipeView.addItem(homePane)
    swipeView.addItem(weatherPane)
    swipeView.addItem(citiesPane)
}

function swipeView_onCurrentIndexChanged() {
    applicationWindow.header.changeTheme(swipeView.currentIndex)
}