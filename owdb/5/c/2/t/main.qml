import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    id: upperParagraph
    text: qsTr("This example application have been built by passionate " +
          "developers with using Objectwheel to introduce best application " +
          "building experience to our users.")
    wrapMode: Label.WordWrap
    anchors.left: icon.right
    anchors.top: parent.top
    anchors.leftMargin: 15
    anchors.right: parent.right
}
