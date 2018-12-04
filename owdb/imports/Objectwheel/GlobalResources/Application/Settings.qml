pragma Singleton
import QtQuick 2.6

QtObject {
    property string theme: "dark"
    property bool dark: true // Implies use of the dark or light theme
    property bool metric: true // Implies use of the metric or imperial system
    property string language: Qt.locale().name.substr(0, 2)
}