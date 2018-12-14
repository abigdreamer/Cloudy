import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0

Label {
    id: emptyLabel
    height: 20
    width: 200
    text: qsTr("Empty")
    anchors.centerIn: parent
    color: Settings.theme === 'Dark' ? "#55ffffff" : "#55000000"
    Behavior on color { SmoothColorAnimation {} }
    visible: trendsList.count === 0
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}
