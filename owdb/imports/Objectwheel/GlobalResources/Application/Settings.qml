pragma Singleton
import QtQuick 2.6

QtObject {
    property bool darkTheme: true
    property bool metricSystem: true
    property string language: Qt.locale().name.substr(0, 2) 
}