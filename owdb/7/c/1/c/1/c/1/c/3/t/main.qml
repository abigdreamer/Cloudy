import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0

ComboBox {
    id: langBox
    height: 45
    width: 120
    model: Settings.availableLanguages
    displayText: qsTr(currentText)
    anchors.rightMargin: 16
    anchors.right: parent.right
    anchors.top: langTitle.top
    anchors.topMargin: -3
    Cursor {}
}
