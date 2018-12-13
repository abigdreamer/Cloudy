import QtQuick 2.7
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0
import QtGraphicalEffects 1.0
import Application 1.0

Page {
    id: newsPane
    width: 376
    height: 564
    Component.onCompleted: NewsPaneJS.newsPane_onCompleted()
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
            Column {
                spacing: 5
                Label {
                    width: dlgNews.availableWidth
                    text: news ? news.title : ""
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
                        source: news ? news.imageUrl : ""
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
                                text: qsTr("Source: ") + (news ? news.sourceName : "")
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
                    text: news ? news.description : ""
                    wrapMode: Label.WordWrap
                    font.italic: true
                    font.weight: Font.Medium
                }
                Item { width: 1; height: 1 }
                Label {
                    width: dlgNews.availableWidth
                    text: (news ? news.content : "") +
                          ' <a href="%1">more...</a>'.arg(news ? news.sourceUrl : "")
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
                    text: qsTr("Published at: ") + (news
                          ? news.date.toLocaleString(
                              Qt.locale(Settings.languageCode()))
                          : "")
                    font.italic: true
                    wrapMode: Label.WordWrap
                }
            }
        }
    }
    
    property var news: null
    property alias newsDialog: dlgNews
}
