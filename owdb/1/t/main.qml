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
  
    header: ToolBar {
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
        ColorAnimation on Material.background { to: "#4689F2"; id: blueAnim; duration: 300 }
        ColorAnimation on Material.background { to: "#7EB643"; id: greenAnim; duration: 300 }
        ColorAnimation on Material.background { to: "#DA453D"; id: redAnim; duration: 300 }
        
        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                Cursor {}
                icon.source: Resource.images.other.drawer
                onClicked: {
                    drawer.open()
                }
            }

            Label {
                id: titleLabel
                text: swipeView.currentItem ? swipeView.currentItem.title : "Cloudy"
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
                        onTriggered: tabbar.currentIndex = 2
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
            color: Settings.dark ? "#404447" : "#e2e2e2"
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
}