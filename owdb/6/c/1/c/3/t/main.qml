import QtQuick 2.9
import Application 1.0

ListView {
    y: 55
    x: 12
    id: citySearchList
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: searchField.bottom
    anchors.bottom: addFinishButton.top
    anchors.topMargin: 10
    anchors.bottomMargin: 10
    highlightMoveDuration: 200
    delegate: CitySearchListDelegate {}
    highlight: Rectangle {
        color: Settings.theme === 'Dark' ? "#30ffffff" : "#10000000"
        Behavior on color { SmoothColorAnimation {} }
    }
    model: ListModel {}
    
    property real longestWidth: 0
    signal cityAdded(var listElement)
}
