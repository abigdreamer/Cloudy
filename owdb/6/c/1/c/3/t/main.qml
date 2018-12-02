import QtQuick 2.9
import Application 1.0

ListView {
    id: citySearchList
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: searchField.bottom
    anchors.bottom: addFinishButton.top
    delegate: CityListDelegate {}
}
