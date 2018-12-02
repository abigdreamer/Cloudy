import QtQuick 2.7
import QtQuick.Controls 2.2

TextField {
    id: searchField
    placeholderText: qsTr("Search: e.g.") + " Sakarya, TR"
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.margins: 5
}
