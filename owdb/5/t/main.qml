import QtQuick 2.7
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0

Dialog {
    id: aboutDialog
    modal: true
    focus: true
    title: "About"
    x: (applicationWindow.width - width) / 2
    y: applicationWindow.height / 6
    width: Math.min(applicationWindow.width, applicationWindow.height) / 3 * 2
    contentHeight: aboutColumn.height
    Component.onCompleted: AboutDialogJS.aboutDialog_onCompleted()

    Column {
        id: aboutColumn
        spacing: 20

        Label {
            width: aboutDialog.availableWidth
            text: "The Qt Quick Controls 2 module delivers the next generation user interface controls based on Qt Quick."
            wrapMode: Label.Wrap
            font.pixelSize: 12
        }

        Label {
            width: aboutDialog.availableWidth
            text: "In comparison to the desktop-oriented Qt Quick Controls 1, Qt Quick Controls 2 "
                + "are an order of magnitude simpler, lighter and faster, and are primarily targeted "
                + "towards embedded and mobile platforms."
            wrapMode: Label.Wrap
            font.pixelSize: 12
        }
    }
}