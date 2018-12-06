import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    id: lowerParagraph
    text: qsTr("Objectwheel is an application programming platform based on Qt. " +
          "We are trying to combine best programming tools with the easiest " +
          "way of developing.")
    wrapMode: Label.WordWrap
    anchors.left: parent.left
    anchors.top: upperParagraph.bottom
    anchors.topMargin: 15
    anchors.right: parent.right
}
