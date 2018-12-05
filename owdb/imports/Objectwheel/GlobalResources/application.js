// application.js
.import Application 1.0 as App
.import QtQuick.Controls.Material 2.2 as QM

function application_onCompleted() {
    swipeView.currentIndexChanged.connect(swipeView_onCurrentIndexChanged)
    App.Settings.themeChanged.connect(settings_onThemeChanged)
    swipeView.addItem(homePane)
    swipeView.addItem(weatherPane)
    swipeView.addItem(citiesPane)
    settings_onThemeChanged()
}

function swipeView_onCurrentIndexChanged() {
    applicationWindow.header.changeTheme(swipeView.currentIndex)
}

function settings_onThemeChanged() {
    var dark = App.Settings.theme === 'Dark'
    applicationWindow.changeTheme(dark)
    App.Utils.delayCall(300, applicationWindow, function() {
        applicationWindow.QM.Material.theme
                = dark ? QM.Material.Dark : QM.Material.Light
    })
}
