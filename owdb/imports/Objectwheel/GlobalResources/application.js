// application.js
.import Application 1.0 as App
.import QtQuick.Controls.Material 2.2 as QM

function application_onCompleted() {
    swipeView.currentIndexChanged.connect(swipeView_onCurrentIndexChanged)
    App.Settings.darkChanged.connect(settings_onDarkChanged)
    swipeView.addItem(homePane)
    swipeView.addItem(weatherPane)
    swipeView.addItem(citiesPane)
}

function swipeView_onCurrentIndexChanged() {
    applicationWindow.header.changeTheme(swipeView.currentIndex)
}

function settings_onDarkChanged() {
    var dark = App.Settings.dark
    applicationWindow.changeTheme(dark)
    App.Utils.delayCall(300, applicationWindow, function() {
        applicationWindow.QM.Material.theme
                = dark ? QM.Material.Dark : QM.Material.Light
    })
}
