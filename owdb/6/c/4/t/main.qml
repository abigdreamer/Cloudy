import QtQuick 2.9
import QtQuick.Controls 2.2
import Application 1.0

ListView {
    id: cityList
    clip: true
    anchors.fill: parent
    anchors.margins: 10
    highlightMoveDuration: 200
    delegate: CityListDelegate {}
    highlight: Rectangle {
        color: Settings.theme === 'Dark' ? "#30ffffff" : "#10000000"
        Behavior on color { SmoothColorAnimation {} }
    }
    model: ListModel {}
    
    ScrollIndicator.vertical: ScrollIndicator { }
    
    signal jumpToCity(var listElement)
}
