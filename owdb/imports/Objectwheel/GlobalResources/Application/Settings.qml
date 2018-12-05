pragma Singleton
import QtQuick 2.6

QtObject {
    property bool themeBalloonVisible: true
    property string theme: 'Light'
    property string themeAccent: 'Colorful'
    property string language: 'Auto'
    property string measurementSystem: 'Auto'

    readonly property var availableThemes:
        ["Dark", "Light"]
    readonly property var availableLanguages:
        ["Auto", "English", "Türkçe"]
    readonly property var availableMeasurementSystems:
        ["Auto", "Metric", "Imperial"]
    readonly property var availableThemeAccents: [
        { "name": "Red", "color": "#DA453D" },
        { "name": "Indigo", "color": "#673AB7" },
        { "name": "Blue", "color": "#4689F2" },
        { "name": "Green", "color": "#7EB643" },
        { "name": "Orange", "color": "#FF9800" },
        { "name": "Brown", "color": "#795548" },
        { "name": "Colorful", "color": "#ffffff" }
    ]
    
    function isMetric() {
        if (measurementSystem === 'Metric')
            return true
        if (measurementSystem === 'Auto')
            return Qt.locale().measurementSystem === Locale.MetricSystem
        return false
    }
    
    function languageCode() {
        if (language === 'Auto')
            return Qt.locale().name.substr(0, 2)
        if (language === 'Türkçe')
            return 'tr'
        return 'en'
    }
}