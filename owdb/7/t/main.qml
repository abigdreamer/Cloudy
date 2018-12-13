import QtQuick 2.7
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0

Page {
    id: settingsPane
    Component.onCompleted: SettingsPaneJS.settingsPane_onCompleted()
    width: applicationWindow.stW.width
    height: applicationWindow.stW.height
}
