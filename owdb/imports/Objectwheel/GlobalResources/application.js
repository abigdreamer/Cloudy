// application.js
.import Application 1.0 as App
.import Application.Resources 1.0 as AppRes
.import QtQuick.Controls.Material 2.2 as QM
.import Objectwheel.Core 1.0 as OC

function application_onCompleted() {
    if (Qt.platform.os !== "ios" && Qt.platform.os !== "android") {
        maximumWidth = 370
        maximumHeight = 650
        minimumWidth = 370
        minimumHeight = 650
    }
    
    App.Settings.themeChanged.connect(settings_onThemeChanged)
    swipeView.addItem(newsSection)
    swipeView.addItem(weatherSection)
    swipeView.addItem(videosSection)
    restoreSettings()
}

function settings_onThemeChanged() {
    applicationWindow.applyThemeChange()
    App.Utils.delayCall(300, applicationWindow, function() {
        applicationWindow.QM.Material.theme = App.Settings.theme === 'Dark'
                ? QM.Material.Dark : QM.Material.Light
    })
}

function restoreSettings() {
    settings_onThemeChanged()
    if (App.Settings.themeAccent === 'Colorful') {
        applicationWindow.header.randomAccent()
    } else {
        applicationWindow.changeAccent(App.Settings.themeAccent)
        applicationWindow.header.changeAccent(App.Settings.themeAccent)
    }
    
    if (App.Settings.languageCode() === 'en')
        OC.Translation.clear()
    else
        OC.Translation.load(AppRes.Resource.translations[App.Settings.languageCode()])
}
