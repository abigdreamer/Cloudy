import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0
import Objectwheel.GlobalResources 1.0

ApplicationWindow {
    id: applicationWindow
    width: 370
    height: 650
    visible: true
    title: qsTr("Cloudy")    
    Component.onCompleted: ApplicationJS.application_onCompleted()

    SmoothColorAnimation on Material.background { to: "#ffffff"; id: lightAnim}
    SmoothColorAnimation on Material.foreground { to: "#555555"; id: lightAnim2}
    SmoothColorAnimation on Material.background { to: "#333432"; id: darkAnim }
    SmoothColorAnimation on Material.foreground { to: "#ffffff"; id: darkAnim2 }

    function changeTheme(dark) {
        if (dark) {
            darkAnim.restart()
            darkAnim2.restart()
        } else {
            lightAnim.restart()
            lightAnim2.restart()
        }
    }

    header: ToolBar {
        SmoothColorAnimation on Material.background { to: "#4689F2"; id: blueAnim }
        SmoothColorAnimation on Material.background { to: "#7EB643"; id: greenAnim }
        SmoothColorAnimation on Material.background { to: "#DA453D"; id: redAnim }
        
        function changeTheme(index) {
            switch (index) {
            case 0:
                Material.theme = Material.Light
                redAnim.restart()
                Material.foreground = "white"
                break
            
            case 1:
                Material.theme = Material.Light
                greenAnim.restart()
                Material.foreground = "white"
                break
            
            case 2:
                Material.theme = Material.Light
                blueAnim.restart()
                Material.foreground = "white"
                break
            }
        }

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                Cursor {}
                icon.source: stackView.currentItem === swipeView
                             ? Resource.images.other.drawer
                             : Resource.images.other.back
                onClicked: {
                    stackView.currentItem === swipeView
                        ? drawer.open()
                        : stackView.pop()
                             
                }
            }

            Label {
                id: titleLabel
                text: stackView.currentItem === swipeView
                      ? (swipeView.currentItem ? swipeView.currentItem.title : qsTr("Cloudy"))
                      : qsTr("Settings")
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                Cursor {}
                icon.source: Resource.images.other.menu
                onClicked: optionsMenu.open()
                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: qsTr("Settings")
                        enabled: stackView.currentItem === swipeView
                        onTriggered: stackView.push(settingsPane)
                        icon.source: Resource.images.other.settings
                        icon.color: "transparent"
                        Cursor {}
                    }
                    MenuItem {
                        text: qsTr("About")
                        onTriggered: aboutDialog.open()
                        icon.source: Resource.images.other.about
                        icon.color: "transparent"
                        Cursor {}
                    }
                }
            }
        }
    }
    
    footer: Rectangle {
        height: tabbar.height
        width: applicationWindow.width
        visible: stackView.currentItem === swipeView
        TabBar {
            id: tabbar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            TabButton {
                icon.source: Resource.images.other.home
                text: qsTr("Home")
                icon.color: "transparent"
                Cursor {}
            }
            TabButton {
                icon.source: Resource.images.other.weather
                text: qsTr("Weather")
                icon.color: "transparent"
                Cursor {}
            }
            TabButton {
                icon.source: Resource.images.other.myCities
                text: qsTr("My Cities")
                icon.color: "transparent"
                Cursor {}
            }
        }
        Rectangle {
            height: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            color: Settings.theme === 'Dark' ? "#404447" : "#e2e2e2"
            Behavior on color { SmoothColorAnimation {} }
        }
    }
 
    Drawer {
        id: drawer
        width: Math.min(applicationWindow.width, applicationWindow.height) / 3 * 2
        height: applicationWindow.height
        interactive: true

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                    stackView.push(model.source)
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement { title: "BusyIndicator"; source: "qrc:/pages/BusyIndicatorPage.qml" }
                ListElement { title: "Button"; source: "qrc:/pages/ButtonPage.qml" }
                ListElement { title: "CheckBox"; source: "qrc:/pages/CheckBoxPage.qml" }
                ListElement { title: "ComboBox"; source: "qrc:/pages/ComboBoxPage.qml" }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    property var tabBar: tabbar
    property var sW: swipeView
    property var stW: stackView
}