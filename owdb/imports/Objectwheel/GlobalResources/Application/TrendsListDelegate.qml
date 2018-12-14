import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0

ItemDelegate {
    id: delegate
    height: 200
    width: ListView.view.width
    clip: true
    property var listView: ListView.view

}
