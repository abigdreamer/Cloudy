import QtQuick 2.9
import QtQuick.Controls 2.2

Slider {
    id: control
    value: 0.5
    padding: 0
    leftPadding: 0
    rightPadding: 0
    bottomPadding: 0
    topPadding: 0
    background: Rectangle {
        x: horizontal ? 0 : (control.width - width) / 2.0
        y: horizontal ? (control.height - height) / 2.0 : 0
        width: horizontal ? control.width : 5
        height: horizontal ? 5 : control.height
        radius: 2.5
        color: "#35ffffff"
        
        Rectangle {
            x: 0
            y: horizontal ? 0 : parent.height
               - control.value * (parent.height - handle.height) - handle.height / 2.0
            height: horizontal ? parent.height :
               control.value * (parent.height - handle.height) + handle.height / 2.0
            width: horizontal ? control.value * (parent.width - handle.width)
               + handle.width / 2.0 : parent.width
            radius: horizontal ? height / 2.0 : width / 2.0
            color: "#60ffffff"
        }
    }
    handle: Rectangle {
        x: horizontal
           ? control.value * (control.width - width)
           : (control.width - width) / 2.0
        y: horizontal
           ? (control.height - height) / 2.0
           : control.height - control.value * (control.height - height) - height
        color: control.pressed ? "#f0f0f0" : "#ffffff"
        height: 10
        width: 10
        radius: 5
    }
    property var videoPlayer: null
}
