import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Application 1.0
import Application.Resources 1.0

ComboBox {
    id: locationBox
    height: 45
    width: 130
    model: Settings.availableMeasurementSystems
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
                  ' (%1)'.arg(qsTranslate("Settings", Settings.localMeasurementText())[0])
        font: locationBox.font
        leftPadding: 8
        rightPadding: 8
        highlighted: locationBox.highlightedIndex === index
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
