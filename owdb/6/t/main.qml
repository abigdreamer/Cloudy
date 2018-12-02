import QtQuick 2.7
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0

Page {
    id: citiesPane
    title: qsTr("My Cities")
    width: 342
    height: 608
    Component.onCompleted: CitiesPaneJS.citiesPane_onCompleted()
}