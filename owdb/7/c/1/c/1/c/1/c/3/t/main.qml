import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0
import Application.Resources 1.0
import QtQuick.Controls.Material 2.2

ComboBox {
    id: langBox
    height: 45
    width: 130
    model: Settings.availableLanguages
    displayText: qsTranslate("Settings", currentText)
    anchors.rightMargin: 16
    anchors.right: parent.right
    anchors.top: langTitle.top
    anchors.topMargin: -3
    delegate: ItemDelegate {
        width: langBox.width
        text: qsTranslate("Settings", langBox.model[index])
        font: langBox.font
        leftPadding: 8
        rightPadding: 8
        icon.width: 24
        icon.height: 16
        icon.source: Resource.images.flag[Settings.flagCode(langBox.model[index])]
        icon.color: "transparent"
        highlighted: langBox.highlightedIndex === index
        TintImage {
            anchors.right: parent.right
            anchors.rightMargin: 13
            anchors.verticalCenter: parent.verticalCenter
            width: 8
            height: 8
            z: 1
            tintColor: Material.accent
            icon.source: Resource.images.other.colorful
            visible: langBox.currentIndex === index
        }

        Cursor {}
    }
    Cursor {}
}
