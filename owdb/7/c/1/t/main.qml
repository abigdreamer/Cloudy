import QtQuick 2.8
import QtQuick.Controls 2.2

ScrollView {
    y: 0
    x: 0
    id: scrollArea
    anchors.fill: parent
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AsNeeded
}
