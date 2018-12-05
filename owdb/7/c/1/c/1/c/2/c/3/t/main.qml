import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0

ComboBox {
    y: 30
    x: 239
    id: measurementBox
    height: 45
    width: 120
    model: Settings.availableMeasurementSystems
    displayText: qsTr(currentText)
    anchors.rightMargin: 16
    anchors.right: parent.right
    anchors.top: measurementTitle.top
    anchors.topMargin: -3
    Cursor {}
}
