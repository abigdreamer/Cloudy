pragma Singleton
import QtQuick 2.6
import Qt.labs.settings 1.0

Settings {
    property bool themeBalloonVisible: true
    property string theme: 'Light'
    property string themeAccent: 'Blue'
    property string language: 'Auto'
    property string location: 'Auto'
    property string measurementSystem: 'Auto'

    readonly property var availableThemes: [
        QT_TRANSLATE_NOOP("Settings", "Dark"),
        QT_TRANSLATE_NOOP("Settings", "Light")
    ]
    readonly property var availableLanguages: [
        QT_TRANSLATE_NOOP("Settings", "Auto"),
        QT_TRANSLATE_NOOP("Settings", "English"),
        QT_TRANSLATE_NOOP("Settings", "Turkish")
    ]
    readonly property var availableMeasurementSystems: [
        QT_TRANSLATE_NOOP("Settings", "Auto"),
        QT_TRANSLATE_NOOP("Settings", "Metric"),
        QT_TRANSLATE_NOOP("Settings", "Imperial")
    ]
    readonly property var availableThemeAccents: [
        { "name": QT_TRANSLATE_NOOP("Settings", "Red"), "color": "#DA453D" },
        { "name": QT_TRANSLATE_NOOP("Settings", "Indigo"), "color": "#673AB7" },
        { "name": QT_TRANSLATE_NOOP("Settings", "Blue"), "color": "#4689F2" },
        { "name": QT_TRANSLATE_NOOP("Settings", "Green"), "color": "#7EB643" },
        { "name": QT_TRANSLATE_NOOP("Settings", "Orange"), "color": "#ed9702" },
        { "name": QT_TRANSLATE_NOOP("Settings", "Brown"), "color": "#795548" },
        { "name": QT_TRANSLATE_NOOP("Settings", "Colorful"), "color": "#ffffff" }
    ]
    
    function accentColor(name) {
        for (var i = 0; i < availableThemeAccents.length; ++i) {
            var accent = availableThemeAccents[i]
            if (accent.name === name)
                return accent.color
        }
        console.trace()
        return null
    }
    function localMeasurementText() {
        return Qt.locale().measurementSystem === Locale.MetricSystem ? 'Metric' : 'Imperial'
    }
    function isMetric() {
        if (measurementSystem === 'Metric')
            return true
        if (measurementSystem === 'Auto')
            return Qt.locale().measurementSystem === Locale.MetricSystem
        return false
    }
    function languageCode(lang) {
        var localCode = Qt.locale().name.substr(0, 2).toLowerCase()
        if (!lang)
            lang = language
        if (lang === 'Auto'
                && (localCode === 'tr' || localCode === 'en'))
            return localCode
        if (lang === 'Turkish')
            return 'tr'
        return 'en'
    }
    function flagCode(lang) {
        var langCode = languageCode(lang)
        if (langCode === 'tr')
            return 'TR'
        return 'US'
    }
    function countryCode() {
        return Qt.locale().name.substr(3, 2).toLowerCase()
    }
    function countrySettingToCode(setting) {
        return setting === 'Auto' ? countryCode() : setting.toLowerCase()
    }
}
