import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0

SwipeDelegate {
    id: delegate
    height: 75
    width: listView.width
    clip: false
    property var listView: ListView.view

    swipe.left: Rectangle {
        id: swipeRect
        width: delegate.height
        height: parent.height
        clip: true
        color: SwipeDelegate.pressed ? "#73A53D" : "#7EB643"
        
        Label {
            text: qsTr("Add")
            color: "white"
            anchors.fill: parent
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            opacity: swipe.position > 0 ? 1 : 0
            Behavior on opacity { NumberAnimation { } }
        }

        DropShadow {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            radius: 25
            samples: 15
            color: "#40000000"
            source: Rectangle {
                width: 10
                height: swipeRect.height
            }
            id: dropShadow
        }
        
        Cursor {}
        
        SwipeDelegate.onClicked: {   
            dropShadow.opacity = 0
            delegate.swipe.close()
            listView.cityAdded(listView.model.get(index))
            listView.model.remove(index, 1)
        }
        SwipeDelegate.onPressedChanged: undoTimer.stop()
    }

    swipe.transition: Transition {
        PropertyAnimation { duration: 500; easing.type: Easing.OutExpo }
    }

    ListView.onRemove: SequentialAnimation {
        PropertyAction { target: delegate; property: "ListView.delayRemove"; value: true }
        PropertyAction { target: containerItem; property: "animStarted"; value: true }
        NumberAnimation { target: containerItem; property: "rerWidth"; to: delegate.width; duration: 500; easing.type: Easing.OutExpo }
        NumberAnimation { target: delegate; property: "height"; to: 0; duration: 500; easing.type: Easing.OutExpo }
        PropertyAction { target: delegate; property: "ListView.delayRemove"; value: false }
    }

    Timer {
        id: undoTimer
        interval: 3600
        onTriggered: delegate.swipe.close()
    }

    swipe.onCompleted: undoTimer.start()

    Item {
        id: containerItem
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        x: delegate.swipe.position * (delegate.swipe.leftItem ? delegate.swipe.leftItem.width : 0)
        width: parent.width
        property bool animStarted: false
        property real rerWidth: 0
        Rectangle {
            id: removeEffectRectangle
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: "#7EB643"
            width: containerItem.rerWidth
        }
        SmoothColorAnimation on Material.foreground {
            running: containerItem.animStarted;
            to: "white"
            duration: 500
            easing.type: Easing.OutExpo
        }
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPressed: {
                mouse.accepted = false
                undoTimer.stop()
                delegate.swipe.close()
            }
            onContainsMouseChanged: {
                if (containsMouse)
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
                source: Resource.images.weatherCondition[iconName]
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
                        source: Resource.images.flag[country.toUpperCase()]
                    }
                    Label {
                        text: city + ", " + country.toUpperCase()
                        font.bold: true
                        font.pixelSize: 14
                    }
                }
                Label {
                    font.pixelSize: 13
                    text: qsTr("Coords: [%1, %2]").arg(latitude.toFixed(2)).arg(longitude.toFixed(2))
                }
                Row {
                    spacing: 1
                    Label {
                        id: l
                        text: Utils.toCleanTemp(temp, Settings.isMetric()) + ','
                        font.bold: true
                        font.pixelSize: 13
                    }
                    Label {
                        text: Utils.toTitleCase(weatherDescription)
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
                        text: cloudiness + "%"
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
                        text: humidity + "%"
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
                        text: Utils.toCleanSpeed(windSpeed, Settings.isMetric())
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
            Material.background: Material.accent
            Material.foreground: "white"
            Cursor {
                id: cursor
                hoverEnabled: true
            }
            onClicked: {   
                listView.cityAdded(listView.model.get(index))
                listView.model.remove(index, 1)
                opacity = 0
            }
            Behavior on opacity { NumberAnimation {} }
        }
    }

    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Settings.theme === 'Dark' ? "#404447" : "#e9e9e9"
        Behavior on color { SmoothColorAnimation {} }
        visible: index !== listView.count - 1
    }
}
