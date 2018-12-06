import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Application 1.0
import Application.Resources 1.0

ComboBox {
    y: 30
    x: 241
    id: themeBox
    height: 45
    width: 120
    model: Settings.availableThemes
    displayText: qsTr(currentText)
    anchors.rightMargin: 16
    anchors.right: parent.right
    anchors.top: themeTitle.top
    anchors.topMargin: -3
    delegate: ItemDelegate {
        width: themeBox.width
        text: qsTr(themeBox.model[index])
        font: themeBox.font
        leftPadding: 8
        rightPadding: 8
        icon.width: 24
        icon.height: 24
        icon.source: Resource.images.other.colorful
        icon.color: themeBox.model[index] === "Dark"
                    ? "#323331"
                    : "#ffffff"
        TintImage {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 8
            width: 24
            height: 24
            z: 1
            tintColor: themeBox.model[index] === "Dark"
                    ? "#323331"
                    : "#ffffff"
            icon.source: Resource.images.other.colorful
            borderWidth: themeBox.model[index] === Settings.theme
            borderColor: Material.accent
        }
        highlighted: themeBox.highlightedIndex === index
        TintImage {
            anchors.left: parent.left
            anchors.leftMargin:8
            anchors.verticalCenter: parent.verticalCenter
            icon.sourceSize: Qt.size(24, 24)
            width: 24
            height: 24
            z: 2
            icon.source: Resource.images.other.check
            tintColor: Material.accent
            visible: themeBox.currentIndex === index
        }
        Cursor {}
    }
    Cursor {}
}
