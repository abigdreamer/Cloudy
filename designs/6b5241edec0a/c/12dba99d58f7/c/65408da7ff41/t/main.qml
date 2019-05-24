import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0

RoundButton {
    y: 0
    x: 278
    id: cleanSearchFieldButton
    width: height
    text: "\u00d7"
    font.weight: Font.Light
    font.pixelSize: 30
    leftPadding: 0
    rightPadding: 0
    bottomPadding: 4
    topPadding: 0
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    background: Item{}
    Cursor{}
    visible: searchField.text !== ""
}
