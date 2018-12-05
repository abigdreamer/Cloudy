import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0

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
    }
    Cursor {}
}
