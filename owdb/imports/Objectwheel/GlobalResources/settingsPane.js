// settingsPane.js
.import Application 1.0 as App
.import Objectwheel.Core 1.0 as OC
.import Application.Resources 1.0 as AppRes

function settingsPane_onCompleted() {
    langBox.activated.connect(langBox_onActivated)
    themeAccentBox.activated.connect(themeAccentBox_onActivated)
    themeBox.activated.connect(themeBox_onActivated)
    App.Settings.themeChanged.connect(settings_onThemeChanged)
    measurementBox.activated.connect(measurementBox_onActivated)
    themeBalloonSwitch.toggled.connect(themeBalloonSwitch_onToggled)
    
    //We wait until all the components on the page to be loaded
    App.Utils.delayCall(1000, settingsPane, retrieveSettingInfo)
}

function settings_onThemeChanged() {
    themeBox.currentIndex = themeBox.find(App.Settings.theme)
}

function themeBalloonSwitch_onToggled() {
    App.Settings.themeBalloonVisible = themeBalloonSwitch.checked
}

function measurementBox_onActivated() {
    App.Settings.measurementSystem = measurementBox.currentText
}

function themeBox_onActivated() {
    App.Settings.theme = themeBox.currentText
}

function themeAccentBox_onActivated() {
    App.Settings.themeAccent = themeAccentBox.currentText
    if (App.Settings.themeAccent === 'Colorful') {
        applicationWindow.header.randomAccent()
    } else {
        applicationWindow.changeAccent(App.Settings.themeAccent)
        applicationWindow.header.changeAccent(App.Settings.themeAccent)
    }
}

function langBox_onActivated() {
    if (App.Settings.languageCode()
            === App.Settings.languageCode(langBox.currentText)) {
        return
    }
    App.Settings.language = langBox.currentText
    if (App.Settings.languageCode() === 'en')
        OC.Translation.clear()
    else
        OC.Translation.load(AppRes.Resource.translations[App.Settings.languageCode()])
}

function retrieveSettingInfo() {
    themeBalloonSwitch.checked = App.Settings.themeBalloonVisible
    measurementBox.currentIndex = measurementBox.find(App.Settings.measurementSystem)
    themeBox.currentIndex = themeBox.find(App.Settings.theme)
    themeAccentBox.currentIndex = themeAccentBox.find(App.Settings.themeAccent)
    langBox.currentIndex = langBox.find(App.Settings.language)
}
