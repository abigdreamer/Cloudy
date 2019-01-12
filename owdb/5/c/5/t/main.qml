import QtQuick 2.9
import QtQuick.Controls 2.3
import Application.Resources 1.0
import QtQuick.Controls.Material 2.2

Item {
    id: poweredByQt
    anchors.left: parent.left
    anchors.top: lowerParagraph.bottom
    anchors.topMargin: 15
    width: 105
    height: 25
    
    Label {
        id: text
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: qsTr("Powered by")
        font.weight: Font.Medium
    }
    
    Image {
        width: 20
        height: 20
        sourceSize: Qt.size(20, 20)
        anchors.left: text.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        source: Resource.images.other.qtLogo
    }
}
