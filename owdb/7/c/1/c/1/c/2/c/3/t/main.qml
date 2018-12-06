import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Application 1.0
import Application.Resources 1.0

ComboBox {
    y: 30
    x: 239
    id: measurementBox
    height: 45
    width: 130
    model: Settings.availableMeasurementSystems
    displayText: qsTranslate("Settings", currentText)
    anchors.rightMargin: 16
    anchors.right: parent.right
    anchors.top: measurementTitle.top
    anchors.topMargin: -3
    delegate: ItemDelegate {
        width: measurementBox.width
        text: measurementBox.model[index] !== 'Auto'
                ? qsTranslate("Settings", measurementBox.model[index])
                : qsTranslate("Settings", measurementBox.model[index]) +
                  ' (%1)'.arg(qsTranslate("Settings", Settings.localMeasurementText())[0])
        font: measurementBox.font
        leftPadding: 8
        rightPadding: 8
        highlighted: measurementBox.highlightedIndex === index
        TintImage {
            anchors.right: parent.right
            anchors.rightMargin: 13
            anchors.verticalCenter: parent.verticalCenter
            width: 8
            height: 8
            z: 1
            tintColor: Material.accent
            icon.source: Resource.images.other.colorful
            visible: measurementBox.currentIndex === index
        }

        Cursor {}
    }
    Cursor {}
}
