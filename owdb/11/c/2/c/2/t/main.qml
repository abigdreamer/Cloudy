import QtQuick 2.0
import Application 1.0

Canvas {
    id: arrowDown
    width: 12
    height: 8
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.topMargin: 15
    anchors.rightMargin: 15
    color: Settings.theme === 'Dark' ? "#949494" : "#848484"
    Behavior on color { SmoothColorAnimation {} }
    rotation: titleContainer.showDescription ? 180 : 0
    onColorChanged: requestPaint()
    onPaint: {
        var ctx = getContext("2d");
        ctx.fillStyle = color
        ctx.moveTo(0, 0)
        ctx.lineTo(width, 0)
        ctx.lineTo(width / 2.0, height)
        ctx.lineTo(0, 0)
        ctx.fill()
    }
    property var color
}
