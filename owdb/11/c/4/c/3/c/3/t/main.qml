import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0

TextArea {
    id: description
    background: Item {}
    readOnly: true
    clip: true
    selectByMouse: true
    height: titleContainer.showDescription ? contentHeight + 2 * padding : 0
    width: watchPane.width
    visible: height > 0
    Behavior on height { NumberAnimation { duration: 300 } }
    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Settings.theme === 'Dark' ? "#404447" : "#e2e2e2"
        Behavior on color { SmoothColorAnimation {} }
    }
    Cursor { cursorShape: Qt.IBeamCursor }
    wrapMode: Label.WordWrap
    font.pixelSize: 14
    color: Settings.theme === 'Dark' ? "#949494" : "#848484"
    Behavior on color { SmoothColorAnimation {} }
    padding: 15
    text: qsTr("Published %1").arg(watchPane.video ? Utils.fromNow(watchPane.video.date) : "" ) + '\n\n'
          + (watchPane.video ? watchPane.video.description : "")
}
