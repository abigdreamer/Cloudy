import QtQuick 2.7
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0

Page {
    id: homePane
    width: 376
    height: 564
    Component.onCompleted: HomePaneJS.homePane_onCompleted()
    title: qsTr("Home")
}
