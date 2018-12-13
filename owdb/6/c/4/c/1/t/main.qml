import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import Application 1.0

RoundButton {
    y: 498
    x: 232
    id: addRoundButton
    height: 75
    width: 75
    text: '+'
    font.pixelSize: 36
    font.weight: Font.Light
    Material.theme: Material.Light
    Material.background: Material.accent
    Material.foreground: "white"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.margins: 15
    Cursor {}
}
