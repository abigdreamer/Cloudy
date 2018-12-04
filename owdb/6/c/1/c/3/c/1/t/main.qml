import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0

Label {
    id: noResultLabel
    height: 40
    width: 150
    color: Settings.dark ? "#55ffffff" : "#55000000"
    Behavior on color { SmoothColorAnimation {} }
    anchors.centerIn: parent
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    text: searchField.text === "" ? qsTr("Empty") : qsTr("No results\nfound")
}
