import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0
import Application.Resources 1.0

Item {
    id: tabBar
    height: 200
    width: weatherButton.height
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 5
    
    TabBar {
        id: tabbar
        width: parent.height
        height: weatherButton.height
        transform: [
            Rotation { origin.x: 0; origin.y: 0; angle: -90},
            Translate { y: tabBar.height; x: 0 } 
        ]
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
            icon.source: Resource.images.other.myCities
            icon.color: "transparent"
            Cursor {}
        }
    }
    
    Canvas {
        anchors.fill: parent
        onColorChanged: requestPaint()
        property var color: Settings.theme == 'Dark'
                            ? "#60ffffff" : "#50000000"
        onPaint: {
            var context = getContext("2d")
            context.clearRect(0, 0, width, height);
            context.beginPath()
            context.lineWidth = 1
            context.strokeStyle = color
            context.moveTo(width, 0)
            context.lineTo(0, 0)
            context.lineTo(0, height)
            context.lineTo(width, height)
            context.stroke()
        }
    }
    property var bar: tabbar
}