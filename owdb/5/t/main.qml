import QtQuick 2.7
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0
import Application.Resources 1.0

Dialog {
    id: aboutDialog
    modal: true
    focus: true
    title: qsTr("About")
    anchors.centerIn: parent
    width: 350
    height: 350
    Component.onCompleted: AboutDialogJS.aboutDialog_onCompleted()
}
