import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0

Item {
    height: 60
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
        anchors.leftMargin: 10
        spacing: 10
        Image {
            clip: true
            width: 48; height: 48
            sourceSize: Qt.size(48, 48)
            fillMode: Image.PreserveAspectFit
            smooth: true
            source: Resource.images.flag[modelData.country.toUpperCase()]
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        }
        
        Column {
            id: leftCol
            clip: true
            spacing: 5
            Layout.fillWidth: true
            Label {
                text: modelData.city + ", " + modelData.country.toUpperCase()
                font.weight: Font.Medium
                font.pixelSize: 16
            }
            Label {
                font.pixelSize: 14
                text: qsTr("Coords: [%1, %2]").arg(modelData.latitude.toFixed(2)).arg(modelData.longitude.toFixed(2))
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
        visible: listView.currentIndex === index
        font.pixelSize: 32
        font.weight: Font.Light
        Material.theme: Material.Light
        Material.background: Material.Blue
        Material.foreground: "white"
        Tip { anchors.fill: parent; text: qsTr("Jump to city") }
        Cursor {}
        onClicked: listView.jumpToCity(modelData)
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
