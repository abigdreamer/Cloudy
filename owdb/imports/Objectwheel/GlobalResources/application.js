// application.js
.import Application 1.0 as App
.import QtQuick.Controls.Material 2.2 as QM

function application_onCompleted() {
    App.Settings.themeChanged.connect(settings_onThemeChanged)
    swipeView.addItem(homePane)
    swipeView.addItem(weatherPane)
    swipeView.addItem(citiesPane)
    settings_onThemeChanged()
}

function settings_onThemeChanged() {
    applicationWindow.applyThemeChange()
    App.Utils.delayCall(300, applicationWindow, function() {
        applicationWindow.QM.Material.theme = App.Settings.theme === 'Dark'
                ? QM.Material.Dark : QM.Material.Light
    })
}
