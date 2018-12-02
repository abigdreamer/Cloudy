import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    id: noResultLabel
    height: 40
    width: 150
    color: "#35ffffff"
    anchors.centerIn: parent
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    text: searchField.text === "" ? qsTr("Empty") : qsTr("No results\nfound")
    visible: false
}
