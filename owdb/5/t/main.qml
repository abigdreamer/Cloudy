import QtQuick 2.7
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0
import Application.Resources 1.0

Dialog {
    id: aboutDialog
    modal: true
    focus: true
    title: qsTr("About")
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 350
    height: 350
    Component.onCompleted: AboutDialogJS.aboutDialog_onCompleted()
}