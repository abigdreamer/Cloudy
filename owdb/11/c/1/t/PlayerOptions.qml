import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0

StackView {
    id: root
    clip: true
    width: currentItem.width
    height: currentItem.height

    Behavior on width { NumberAnimation { duration: 170 } }
    Behavior on height { NumberAnimation { duration: 170 } }
    
    onCurrentItemChanged: {
        width = currentItem.width
        height = currentItem.height
    }
    
    initialItem: ColumnLayout {
        width: 160
        height: 55
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: mouseArea.containsMouse ? "#15ffffff" : "transparent"
            radius: 4
            RowLayout {
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.fill: parent
                Text {
                    text: qsTr("Speed")
                    font.weight: Font.DemiBold
                    color: "white"
                    font.pixelSize: 12
                    Layout.alignment: Qt.AlignVCenter
                }
                Item { Layout.fillWidth: true }
                Text {
                    text: qsTr(speed)
                    color: "white"
                    font.pixelSize: 11
                    Layout.alignment: Qt.AlignVCenter
                }
                TintImage {
                    width: 13
                    height: 13
                    tintColor: "white"
                    icon.source: Resource.images.other.back
                    rotation: 180
                    Layout.alignment: Qt.AlignVCenter
                }
            }
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: mouseArea2.containsMouse ? "#15ffffff" : "transparent"
            radius: 4
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                Text {
                    text: qsTr("Quality")
                    font.weight: Font.DemiBold
                    color: "white"
                    font.pixelSize: 12
                    Layout.alignment: Qt.AlignVCenter
                }
                Item { Layout.fillWidth: true }
                Row {
                    spacing: 2
                    Layout.alignment: Qt.AlignVCenter
                    Text {
                        text: qsTr(quality)
                        color: "white"
                        font.pixelSize: 11
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Text {
                        text: Utils.qualityBadge(quality)
                        font.pixelSize: 9
                        font.weight: Font.DemiBold
                        verticalAlignment: Text.AlignTop
                        color: "#FC0D1B"
                    }
                }
                TintImage {
                    width: 13
                    height: 13
                    tintColor: "white"
                    icon.source: Resource.images.other.back
                    rotation: 180
                    Layout.alignment: Qt.AlignVCenter
                }
            }
            MouseArea {
                id: mouseArea2
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.push(qualityComponent)
            }
        }
    }

    Component {
        id: qualityComponent
        ColumnLayout {
            width: 90
            spacing: 2
            height: listView.contentHeight + title.height + spacing
            Item {
                id: title
                clip: true
                height: 22
                Layout.fillWidth: true
                Rectangle {
                    height: 1
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    color: "#40ffffff"
                }
                RowLayout {
                    spacing: 5
                    anchors.fill: parent
                    TintImage {
                        width: 13
                        height: 13
                        tintColor: "white"
                        icon.source: Resource.images.other.back
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Text {
                        text: qsTr("Quality")
                        font.weight: Font.DemiBold
                        color: "white"
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Item { Layout.fillWidth: true }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.pop()
                }
            }
            ListView {
                id: listView
                clip: true
                model: qualities
                Layout.fillWidth: true
                height: Math.min(maxHeight - title.height - parent.spacing,
                                 contentHeight)
                ScrollIndicator.vertical: ScrollIndicator {
                    contentItem: Rectangle {
                        implicitWidth: 2
                        implicitHeight: 20
                        color: "#30ffffff"
                        visible: listView.height < listView.contentHeight
                    }
                } 
                delegate: AbstractButton {
                    id: delegate
                    width: ListView.view.width
                    height: 18
                    autoExclusive: true
                    checked: qualityText.text === quality
                    onClicked: {
                        quality = qualityText.text
                        Utils.delayCall(200, delegate, root.pop)
                    }
                    leftPadding: 0
                    rightPadding: 0
                    topPadding: 0
                    bottomPadding: 0
                    Rectangle {
                        anchors.fill: parent
                        color: mouseArea2.containsMouse ? "#15ffffff" : "transparent"
                        radius: 4
                        RowLayout {
                            anchors.fill: parent
                            spacing: 2
                            Item { Layout.fillWidth: true }
                            Text {
                                visible: delegate.checked
                                text: "\u2713"
                                Layout.alignment: Qt.AlignVCenter
                                color: "white"
                                font.pixelSize: 12
                            }
                            Item { Layout.fillWidth: true }
                            Text {
                                id: qualityText
                                text: qualities[qualities.length - index - 1]
                                color: "white"
                                font.pixelSize: 12
                                Layout.alignment: Qt.AlignVCenter
                            }
                            Text {
                                text: Utils.qualityBadge(qualityText.text)
                                color: "#FC0D1B"
                                font.pixelSize: 10
                                font.weight: Font.Medium
                                Layout.alignment: Qt.AlignTop
                                Layout.preferredWidth: 20
                            }
                        }
                        MouseArea {
                            id: mouseArea2
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onPressed: mouse.accepted = false
                        }
                    }
                }
            }
        }
    }
    
    property var speeds: [
        QT_TRANSLATE_NOOP("PlayerOptions", "0.25"),
        QT_TRANSLATE_NOOP("PlayerOptions", "0.5"),
        QT_TRANSLATE_NOOP("PlayerOptions", "0.75"),
        QT_TRANSLATE_NOOP("PlayerOptions", "Normal"),
        QT_TRANSLATE_NOOP("PlayerOptions", "1.25"),
        QT_TRANSLATE_NOOP("PlayerOptions", "1.5"),
        QT_TRANSLATE_NOOP("PlayerOptions", "1.75"),
        QT_TRANSLATE_NOOP("PlayerOptions", "2"),
    ]
    property string speed: "Normal"
    property string quality: "360p"
    property var qualities: []
    property real maxHeight: 0
}