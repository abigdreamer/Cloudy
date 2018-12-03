import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0

Item {
    height: 75
    width: ListView.view.width
    clip: false
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
            width: 60; height: 60
            sourceSize: Qt.size(60, 60)
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
                spacing: 5
                Image {
                    clip: true
                    width: 18; height: 18
                    sourceSize: Qt.size(18, 18)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: Resource.images.flag[modelData.country.toUpperCase()]
                }
                Label {
                    text: modelData.city + ", " + modelData.country.toUpperCase()
                    font.bold: true
                    font.pixelSize: 14
                }
            }
            Label {
                font.pixelSize: 13
                text: qsTr("Coords: [%1, %2]").arg(modelData.latitude.toFixed(2)).arg(modelData.longitude.toFixed(2))
            }
            Row {
                spacing: 1
                Label {
                    id: l
                    text: Utils.toCleanTemp(modelData.temp, Settings.metric) + ','
                    font.bold: true
                    font.pixelSize: 13
                }
                Label {
                    text: Utils.toTitleCase(modelData.weatherDescription)
                    elide: Label.ElideMiddle
                    width: leftCol.width - l.width - 1
                    font.pixelSize: 13
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
                spacing: 5
                Image {
                    clip: true
                    width: 16; height: 16
                    sourceSize: Qt.size(16, 16)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true
                    source: Resource.images.other.cloudiness
                }
                Label {
                    text: modelData.cloudiness + "%"
                    font.pixelSize: 13
                }
            }
            Row {
                spacing: 5
                Image {
                    clip: true
                    width: 16; height: 16
                    sourceSize: Qt.size(16, 16)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true
                    source: Resource.images.other.humidity
                }
                Label {
                    text: modelData.humidity + "%"
                    font.pixelSize: 13
                }
            }
            Row {
                spacing: 5
                Image {
                    clip: true
                    width: 16; height: 16
                    sourceSize: Qt.size(16, 16)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true
                    source: Resource.images.other.wind
                }
                Label {
                    text: Utils.toCleanSpeed(modelData.windSpeed, Settings.metric)
                    font.pixelSize: 13
                }
            }
        }
    }
    
    RoundButton {
        text: "+"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
        opacity: cursor.containsMouse ? 1.0 : 0.9
        width: 55; height: 55
        visible: listView.currentIndex === index
        font.pixelSize: 32
        font.weight: Font.Light
        Material.theme: Material.Light
        Material.background: "#4689F2"
        Material.foreground: "white"
        Cursor {
            id: cursor
            hoverEnabled: true
        }
    }

    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Settings.dark ? "#404447" : "#e9e9e9"
        visible: index !== listView.count - 1
    }
}
