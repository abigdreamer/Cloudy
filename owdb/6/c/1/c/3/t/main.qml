import QtQuick 2.9
import Application 1.0

ListView {
    id: citySearchList
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: searchField.bottom
    anchors.bottom: addFinishButton.top
    anchors.topMargin: 10
    anchors.bottomMargin: 10
    highlightMoveDuration: 200
    delegate: CityListDelegate {}
    highlight: Rectangle {
        radius: 4
        color: "#30ffffff"
    }

    property real longestWidth: 0
}
