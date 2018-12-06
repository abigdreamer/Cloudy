import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0
import Application.Resources 1.0

ComboBox {
    y: 30
    x: 242
    id: themeAccentBox
    height: 45
    width: 120
    model: Settings.availableThemeAccents
    displayText: qsTr(currentText)
    anchors.rightMargin: 16
    anchors.right: parent.right
    anchors.top: themeAccentTitle.top
    anchors.topMargin: -3
    textRole: "name"
    delegate: ItemDelegate {
        width: themeAccentBox.width
        text: qsTr(modelData.name)
        font: themeAccentBox.font
        leftPadding: 8
        rightPadding: 8
        icon.width: 24
        icon.height: 24
        icon.source: Resource.images.other.colorful
        icon.color: modelData.name === "Colorful"
                    ? "transparent"
                    : modelData.color
        highlighted: themeAccentBox.highlightedIndex === index
        Image {
            anchors.left: parent.left
            anchors.leftMargin:8
            anchors.verticalCenter: parent.verticalCenter
            sourceSize: Qt.size(24, 24)
            width: 24
            height: 24
            z: 1
            source: Resource.images.other.check
            visible: themeAccentBox.currentIndex === index
        }

        Cursor {}
    }
    Cursor {}
}
