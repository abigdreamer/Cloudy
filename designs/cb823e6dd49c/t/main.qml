import QtQuick 2.7
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0
import QtGraphicalEffects 1.0
import Application 1.0

Page {
    id: newsSection
    width: 376
    height: 564
    Component.onCompleted: NewsSectionJS.newsSection_onCompleted()
    title: qsTr("News")
    
    Dialog {
        id: dlgNews
        modal: true
        focus: true
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 350
        height: 400
        onClosed: newsBalloon.flowPaused = false
        ScrollView {
            clip: true
            anchors.fill: parent
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.vertical.interactive: false
            Column {
                spacing: 5
                Label {
                    width: dlgNews.availableWidth
                    text: dialogNews ? dialogNews.title : ""
                    wrapMode: Label.WordWrap
                    font.pixelSize: 16
                    font.weight: Font.Medium
                }
                Item { width: 1; height: 1 }
                Item {
                    width: dlgNews.availableWidth
                    height: 150
                    Image {
                        id: image
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                        source: dialogNews ? dialogNews.imageUrl : ""
                        visible: false
                    }
                    OpacityMask {
                        anchors.fill: image
                        source: image
                        maskSource: Rectangle {
                            width: dlgNews.availableWidth
                            height: 100
                            radius: 4
                        }
                        Rectangle {
                            anchors.right: parent.right
                            anchors.rightMargin: 2
                            anchors.bottomMargin: 2
                            anchors.bottom: parent.bottom
                            height: sourceLabel.height + 2
                            width: sourceLabel.width + 10
                            color: "#90000000"
                            radius: 4
                            Label {
                                id: sourceLabel
                                anchors.margins: 5
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("Source: ") + (dialogNews ? dialogNews.sourceName : "")
                                font.bold: true
                                style: Text.Raised
                                styleColor: "black"
                                color: "white"
                            }
                        }
                    }
                }
                Item { width: 1; height: 5 }
                Label {
                    width: dlgNews.availableWidth
                    text: dialogNews ? dialogNews.description : ""
                    wrapMode: Label.WordWrap
                    font.italic: true
                    font.weight: Font.Medium
                }
                Item { width: 1; height: 1 }
                Label {
                    width: dlgNews.availableWidth
                    text: (dialogNews ? dialogNews.content : "") +
                          ' <a href="%1">more...</a>'.arg(dialogNews ? dialogNews.sourceUrl : "")
                    wrapMode: Label.WordWrap
                    
                    onLinkActivated: Qt.openUrlExternally(link)
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: false
                        onPressed: mouse.accepted = false
                        cursorShape: parent.hoveredLink === "" ? Qt.ArrowCursor : Qt.PointingHandCursor
                    }
                }
                Item { width: 1; height: 1 }
                Label {
                    width: dlgNews.availableWidth
                    font.pixelSize: 11
                    text: qsTr("Published at: ") + (dialogNews
                          ? dialogNews.date.toLocaleString(
                              Qt.locale(Settings.languageCode()))
                          : "")
                    font.italic: true
                    wrapMode: Label.WordWrap
                }
            }
        }
    }
    
    property alias newsDialog: dlgNews
    property var dialogNews: null
    property var news: []
    property int newsIndex: 0
    property var newsBubbles: []
}
