import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Objectwheel.GlobalResources 1.0
import Application 1.0

Item {
    height: 55
    RowLayout {
        spacing: 8
        anchors.fill: parent
        
        Image {
            id: icon
            width: 55; height: 55
            sourceSize: Qt.size(55, 55)
            fillMode: Image.PreserveAspectFit
            smooth: true
            antialiasing: true
            source: UtilsJS.toWeatherIcon(modelData.icon)
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        }
        
        Column {
            spacing: 1
            Row {
                id: title
                spacing: 4
                Image {
                    clip: true
                    width: 16; height: 16
                    sourceSize: Qt.size(16, 16)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true
                    source: modelData.flagImageUrl
                }
                Label {
                    text: modelData.city + ", " + modelData.country.toUpperCase()
                    font.bold: true
                    font.pixelSize: 13
                }
            }
            Label {
                id: coord
                font.pixelSize: 12
                text: qsTr("Coords: [%1, %2]").arg(modelData.latitude.toFixed(2)).arg(modelData.longitude.toFixed(2))
            }
            Row {
                spacing: 1
                Label {
                    text: UtilsJS.toCleanTemp(modelData.temp, Settings.metric) + ','
                    font.bold: true
                    font.pixelSize: 12
                }
                Label {
                    text: UtilsJS.toTitleCase(modelData.weatherDescription)
                    font.pixelSize: 12
                }
            }
        }

        Column {
            spacing: 1
            Row {
                spacing: 4
                Image {
                    clip: true
                    width: 14; height: 14
                    sourceSize: Qt.size(14, 14)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true
                    source: GlobalResources.url() + "/images/icons/cloudiness.png"
                }
                Label {
                    text: modelData.cloudiness + "%"
                    font.pixelSize: 12
                }
            }
            Row {
                spacing: 4
                Image {
                    clip: true
                    width: 14; height: 14
                    sourceSize: Qt.size(14, 14)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true
                    source: GlobalResources.url() + "/images/icons/humidity.png"
                }
                Label {
                    text: modelData.humidity + "%"
                    font.pixelSize: 12
                }
            }
            Row {
                spacing: 4
                Image {
                    clip: true
                    width: 14; height: 14
                    sourceSize: Qt.size(14, 14)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true
                    source: GlobalResources.url() + "/images/icons/wind.png"
                }
                Label {
                    text: UtilsJS.toCleanSpeed(modelData.windSpeed, Settings.metric)
                    font.pixelSize: 12
                }
            }
        }
    }
}
