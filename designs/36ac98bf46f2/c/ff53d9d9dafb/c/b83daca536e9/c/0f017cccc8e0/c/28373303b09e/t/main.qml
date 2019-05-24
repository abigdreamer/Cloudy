import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Application 1.0
import Application.Resources 1.0

ComboBox {
    id: locationBox
    height: 45
    width: 130
    model: {
        var locales = Object.keys(Resource.images.flag)
        locales.unshift('Auto')
        return locales
    }
    displayText: qsTranslate("Settings", currentText)
    anchors.rightMargin: 16
    anchors.right: parent.right
    anchors.top: locationTitle.top
    anchors.topMargin: -3
    delegate: ItemDelegate {
        width: locationBox.width
        text: locationBox.model[index] !== 'Auto'
                ? qsTranslate("Settings", locationBox.model[index])
                : qsTranslate("Settings", locationBox.model[index]) +
                  ' (%1)'.arg(qsTranslate("Settings", Settings.countryCode().toUpperCase()))
        font: locationBox.font
        leftPadding: 8
        rightPadding: 8
        highlighted: locationBox.highlightedIndex === index
        icon.width: 24
        icon.height: 16
        icon.source: Resource.images.flag[
            Settings.countrySettingToCode(locationBox.model[index]).toUpperCase()]
        icon.color: "transparent"
 
        TintImage {
            anchors.right: parent.right
            anchors.rightMargin: 13
            anchors.verticalCenter: parent.verticalCenter
            width: 8
            height: 8
            z: 1
            tintColor: Material.accent
            icon.source: Resource.images.other.colorful
            visible: locationBox.currentIndex === index
        }

        Cursor {}
    }
    Cursor {}
}
