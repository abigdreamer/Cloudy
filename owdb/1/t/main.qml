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

    Timer {
        interval: 2000
        repeat: true
        running: Settings.themeAccent === 'Colorful'
        onTriggered: header.randomAccent()
    }

    SmoothColorAnimation on Material.background { id: themeAnimBackground }
    SmoothColorAnimation on Material.foreground { id: themeAnimForeground }
    function applyThemeChange() {
        if (Settings.theme === 'Dark') {
            themeAnimBackground.to = "#333432"
            themeAnimForeground.to = "#ffffff"
        } else {
            themeAnimBackground.to = "#ffffff"
            themeAnimForeground.to = "#555555"
        }
        themeAnimBackground.restart()
        themeAnimForeground.restart()
    }

    SmoothColorAnimation on Material.accent { id: accentAnimApp }
    function changeAccent(accentName) {
        accentAnimApp.to = Settings.accentColor(accentName)
        accentAnimApp.restart()
    }
        
    header: ToolBar {
        SmoothColorAnimation on Material.background { id: accentAnim }
        function changeAccent(accentName) {
            Material.theme = Material.Light
            accentAnim.to = Settings.accentColor(accentName)
            accentAnim.restart()
            Material.foreground = "white"
        }
        function randomAccent() {
            var newAccent
            do {
                newAccent = Settings.availableThemeAccents
                        [Math.floor(Math.random() * Settings.availableThemeAccents.length)]
            } while (newAccent.name === 'Colorful' || Qt.colorEqual(newAccent.color, accentAnim.to))
            applicationWindow.changeAccent(newAccent.name)
            changeAccent(newAccent.name)
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
                Cursor{}
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
                text: qsTr("Cities")
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
                text: title
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