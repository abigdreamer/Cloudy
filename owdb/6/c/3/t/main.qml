import QtQuick 2.9
import QtQuick.Controls 2.3

Label {
    id: noCityies
    height: 20
    width: 200
    text: qsTr("No Cities")
    anchors.centerIn: parent
    color: "#35ffffff"
    visible: cityList.count === 0
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}
