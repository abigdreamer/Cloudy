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
        id: toolbar
        width: column.width
        height: column.height
        Column {
            id: column
            spacing: 0
            RowLayout {
                spacing: 20
                height: 48
                width: applicationWindow.width
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
                    font.pixelSize: 18
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
            TabBar {
                id: weatherbar
                clip: true
                visible: height > 0
                Behavior on height {
                    SequentialAnimation {
                        PropertyAnimation {
                            duration: 300
                            target: applicationWindow
                            property: "title"
                            to: applicationWindow.title
                        }
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.OutExpo
                        }
                    }
                }
                height: tabbar.currentIndex == 1 && stackView.currentItem === swipeView ? 48 : 0
                width: applicationWindow.width
                Material.accent: "white"
                TabButton {
                    text: qsTr("Weather")
                    icon.source: Resource.images.weatherCondition["01d"]
                    icon.color: "transparent"
                    Cursor {}
                }
                TabButton {
                    text: qsTr("City")
                    icon.source: Resource.images.other.city
                    icon.color: "transparent"
                    Cursor {}
                }
            }
            TabBar {
                id: videosbar
                clip: true
                visible: height > 0
                Behavior on height {
                    SequentialAnimation {
                        PropertyAnimation {
                            duration: 300
                            target: applicationWindow
                            property: "title"
                            to: applicationWindow.title
                        }
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.OutExpo
                        }
                    }
                }
                height: tabbar.currentIndex == 2 && stackView.currentItem === swipeView ? 48 : 0
                width: applicationWindow.width
                Material.accent: "white"
                TabButton {
                    text: qsTr("Trends")
                    icon.source: Resource.images.other.trends
                    icon.color: "transparent"
                    Cursor {}
                }
                TabButton {
                    text: qsTr("Search")
                    icon.source: Resource.images.other.search
                    icon.color: "transparent"
                    Cursor {}
                }
                TabButton {
                    text: qsTr("Watch")
                    icon.source: Resource.images.other.watch
                    icon.color: "transparent"
                    enabled: typeof watchPane.video !== "undefined"
                    Cursor {}
                }
            }
        }
        SmoothColorAnimation on Material.background { id: accentAnim }
        function changeAccent(accentName) {
            Material.theme = Material.Light
            accentAnim.to = Settings.accentColor(accentName)
            accentAnim.restart()
            Material.foreground = "white"
            drawer.changeAccent(accentName)
        }
        function randomAccent() {
            var newAccent
            do {
                newAccent = Settings.availableThemeAccents
                        [Math.floor(Math.random() * Settings.availableThemeAccents.length)]
            } while (newAccent.name === 'Colorful' || Qt.colorEqual(newAccent.color, accentAnim.to))
            applicationWindow.changeAccent(newAccent.name)
            drawer.changeAccent(newAccent.name)
            changeAccent(newAccent.name)
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
                text: qsTr("News")
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
                icon.source: Resource.images.other.playButton
                text: qsTr("Videos")
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
        property var changeAccent: tbar.changeAccent
        
        ColumnLayout {
            anchors.fill: parent
            ToolBar {
                id: tbar
                Layout.fillWidth: true
                Label {
                    anchors.centerIn: parent
                    text: qsTr("Menu")
                    font.pixelSize: 18
                }
                SmoothColorAnimation on Material.background { id: accentAnimDrawerToolbar }
                function changeAccent(accentName) {
                    Material.theme = Material.Light
                    accentAnimDrawerToolbar.to = Settings.accentColor(accentName)
                    accentAnimDrawerToolbar.restart()
                    Material.foreground = "white"
                }
            }
            ListView {
                id: listView
                focus: true
                currentIndex: tabbar.currentIndex
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                delegate: ItemDelegate {
                    width: parent.width
                    text: title
                    font.pixelSize: 15
                    font.weight: Font.Normal
                    highlighted: ListView.isCurrentItem
                    onClicked: {
                        if (stack)
                            stackView.push(settingsPane)
                        else
                            tabBar.currentIndex = index
                        drawer.close()
                    }
                    Cursor {}
                }
                
                model: ListModel {
                    ListElement { title: qsTr("News"); index: 0; stack: false }
                    ListElement { title: qsTr("Weather"); index: 1; stack: false }
                    ListElement { title: qsTr("Videos"); index: 2; stack: false }
                    ListElement { title: qsTr("Settings"); index: 0; stack: true }
                }
                
                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }
    }
    
    property var videosBar: videosbar
    property var weatherBar: weatherbar
    property var tabBar: tabbar
}
