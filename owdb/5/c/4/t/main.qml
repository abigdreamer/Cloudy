import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    id: thanks
    anchors.right: parent.right
    anchors.top: poweredByQt.bottom
    anchors.topMargin: 5
    height: 60
    width: 200
    horizontalAlignment: Text.AlignRight
    verticalAlignment: Text.AlignVCenter
    textFormat: Text.RichText
    text: qsTr("<p><b>Thanks</b></p>" + "<p><i>\u2014 Objectwheel Team</i></p>")
}
