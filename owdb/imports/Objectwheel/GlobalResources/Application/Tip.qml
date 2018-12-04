import QtQuick 2.8
import QtQuick.Controls 2.3

MouseArea {
    hoverEnabled: true
    onPressed: mouse.accepted = false
    ToolTip.visible: containsMouse
    ToolTip.text: text
    ToolTip.toolTip.y: -35
    ToolTip.toolTip.contentItem: Text {
      text: ToolTip.toolTip.text
      font: ToolTip.toolTip.font
      color: "#d0d0d0"
    }
    property string text: "-"
}