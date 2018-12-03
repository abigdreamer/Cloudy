import QtQuick 2.8
import QtQuick.Controls 2.2

Pane {
    y: 0
    x: -347
    id: addCityPane
    width: parent.width
    height: parent.height
    z: 1
    Behavior on y {
        PropertyAnimation {
            easing.type: Easing.OutExpo
            duration: 500
        }
    }
}
