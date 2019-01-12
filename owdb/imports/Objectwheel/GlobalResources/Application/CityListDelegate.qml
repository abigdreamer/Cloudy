import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0

SwipeDelegate {
    id: delegate
    height: 60
    width: ListView.view.width
    clip: true
    property var listView: ListView.view
    property bool weRemoveIt: false
    
    swipe.left: Rectangle {
        id: swipeRect
        width: delegate.height
        height: parent.height
        clip: true
        color: SwipeDelegate.pressed ? "#C93F38" : "#DA453D"
        
        Label {
            text: qsTr("Delete")
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
            weRemoveIt = true
            dropShadow.opacity = 0
            delegate.swipe.close()
            listView.model.remove(index, 1)
        }
        SwipeDelegate.onPressedChanged: undoTimer.stop()
    }

    swipe.transition: Transition {
        PropertyAnimation { duration: 500; easing.type: Easing.OutExpo }
    }

    ListView.onRemove: SequentialAnimation {
        running: weRemoveIt
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
            color: "#DA453D"
            width: weRemoveIt ? containerItem.rerWidth : 0
        }
        SmoothColorAnimation on Material.foreground {
            running: containerItem.animStarted && weRemoveIt
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
            anchors.leftMargin: 10
            spacing: 10
            Image {
                clip: true
                width: 48; height: 48
                sourceSize: Qt.size(48, 48)
                fillMode: Image.PreserveAspectFit
                smooth: true
                source: Resource.images.flag[country.toUpperCase()]
                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            }
            
            Column {
                id: leftCol
                clip: true
                spacing: 5
                Layout.fillWidth: true
                Label {
                    text: city + ", " + country.toUpperCase()
                    font.weight: Font.Medium
                    font.pixelSize: 16
                }
                Label {
                    font.pixelSize: 14
                    text: qsTr("Coords: [%1, %2]").arg(latitude.toFixed(2)).arg(longitude.toFixed(2))
                }
            }
        }
        
        RoundButton {
            icon.source: Resource.images.other.jump
            icon.color: "white"
            icon.width: 24
            icon.height: 24
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
            width: 55; height: 55
            visible: listView.currentIndex === index && !containerItem.animStarted  && listView.currentIndex >= 0
            font.pixelSize: 32
            font.weight: Font.Light
            Material.theme: Material.Light
            Material.background: Material.accent
            Material.foreground: "white"
            Tip { anchors.fill: parent; text: qsTr("Jump to city") }
            Cursor {}
            onClicked: listView.jumpToCity(listView.model.get(index))
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
}
