import QtQuick 2.9
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4

Rectangle {
    id: player
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: Math.floor(width / 1.777)
    color: "black"
    
    
  MouseArea {
      id: touchArea
      anchors.fill: parent
      onClicked: pieMenu.popup(touchArea.mouseX, touchArea.mouseY)
  }

  PieMenu {
      id: pieMenu

      triggerMode: TriggerMode.TriggerOnRelease

      MenuItem {
          text: "Action 1"
          onTriggered: print("Action 1")
      }
      MenuItem {
          text: "Action 2"
          onTriggered: print("Action 2")
      }
      MenuItem {
          text: "Action 3"
          onTriggered: print("Action 3")
      }
  }
  
  property var videos: ({})
  property url audioUrl
}
