import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0
import Application.Resources 1.0
import Objectwheel.GlobalResources 1.0

Page {
    id: weatherSection
    width: 342
    height: 608
    Component.onCompleted: WeatherSectionJS.weatherSection_onCompleted()
    title: qsTr("Weather")
    
    header: TabBar {
    id: tabBar
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    TabButton {
        id: weatherButton
        text: qsTr("Weather")
        icon.source: Resource.images.weatherCondition["01d"]
        icon.color: "transparent"
        Cursor {}
    }
    TabButton {
        id: citiesButton
        text: qsTr("City")
        icon.source: Resource.images.other.city
        icon.color: "transparent"
        Cursor {}
    }
    Canvas {
        anchors.fill: parent
        onColorChanged: requestPaint()
        property var color: Settings.theme === 'Dark' ? "#404447" : "#e2e2e2"
        Behavior on color { SmoothColorAnimation {} }
        onPaint: {
            var context = getContext("2d")
            context.clearRect(0, 0, width, height);
            context.beginPath()
            context.lineWidth = 1
            context.strokeStyle = color
            context.moveTo(width, 0)
            context.lineTo(0.5, 0.5)
            context.lineTo(0.5, height - 0.5)
            context.lineTo(width - 0.5, height - 0.5)
            context.stroke()
        }
    }
    property var bar: tabbar
}

    property var tB: tabBar.bar
}