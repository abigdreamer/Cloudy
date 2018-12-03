import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0

Item {
    height: 55
    width: ListView.view.width
    clip: true
    property var listView: ListView.view
    
   MouseArea {
        anchors.fill: parent
        hoverEnabled: false
        onPressed: {
            mouse.accepted = false
            listView.currentIndex = index
        }
    }
        
    RowLayout {
        anchors.fill: parent
        
        Image {
            clip: true
            width: 55; height: 55
            sourceSize: Qt.size(55, 55)
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: Resource.images.weatherCondition[modelData.icon]
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        }
        
        Column {
            id: leftCol
            clip: true
            spacing: 1
            Layout.fillWidth: true

            Row {
                spacing: 4
                Image {
                    clip: true
                    width: 16; height: 16
                    sourceSize: Qt.size(16, 16)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: Resource.images.flag[modelData.country.toUpperCase()]
                }
                Label {
                    text: modelData.city + ", " + modelData.country.toUpperCase()
                    font.bold: true
                    font.pixelSize: 13
                }
            }
            Label {
                font.pixelSize: 12
                text: qsTr("Coords: [%1, %2]").arg(modelData.latitude.toFixed(2)).arg(modelData.longitude.toFixed(2))
            }
            Row {
                spacing: 1
                Label {
                    id: l
                    text: Utils.toCleanTemp(modelData.temp, Settings.metric) + ','
                    font.bold: true
                    font.pixelSize: 12
                }
                Label {
                    text: Utils.toTitleCase(modelData.weatherDescription)
                    elide: Label.ElideMiddle
                    width: leftCol.width - l.width - 1
                    font.pixelSize: 12
                }
            }
        }

        Column {
            spacing: 1
            clip: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Component.onCompleted: {
                if (width > listView.longestWidth)
                    listView.longestWidth = width
                Utils.delayCall(10, parent, function() {
                    Layout.preferredWidth = listView.longestWidth
                })
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
                    source: Resource.images.other.cloudiness
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
                    source: Resource.images.other.humidity
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
                    source: Resource.images.other.wind
                }
                Label {
                    text: Utils.toCleanSpeed(modelData.windSpeed, Settings.metric)
                    font.pixelSize: 12
                }
            }
        }

        RoundButton {
            text: "+"
            Behavior on x {
                PropertyAnimation{}
            }

            Layout.preferredWidth: 48
            Layout.preferredHeight: 48
            visible: listView.currentIndex === index
            font.pixelSize: 26
            font.weight: Font.Light
            Material.theme: Material.Light
            Material.background: Material.Blue
            Material.foreground: "white"
            Cursor {}
        }
    }
}
