import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    y: 393
    x: 19.5
    id: label
    text: "Qt Quick Controls 2 provides a set of controls that can be used to build complete interfaces in Qt Quick."
    anchors.margins: 20
    anchors.top: logo.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: arrow.top
    horizontalAlignment: Label.AlignHCenter
    verticalAlignment: Label.AlignVCenter
    wrapMode: Label.Wrap
}
