import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

TextField {
    id: searchField
    placeholderText: qsTr("Search: e.g.") + " Sakarya, TR"
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    leftPadding: 8
    rightPadding: 0
    bottomPadding: 0
    topPadding: 0
    height: 35
    background: Rectangle {
        color: "#30ffffff"
        radius: 4
    }
}
