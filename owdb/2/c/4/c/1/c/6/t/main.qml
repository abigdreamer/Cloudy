import Application 1.0
import Application.Resources 1.0

WeatherItem {
    id: humidity
    clip: true
    width: 90
    height: 25
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: -height/2.0 -2
    anchors.leftMargin: 10
    iconSource: Resource.images.other.humidity
    tip: qsTr("Humidity")
}