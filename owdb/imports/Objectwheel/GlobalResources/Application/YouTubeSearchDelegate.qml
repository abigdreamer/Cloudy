import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0
import YouTubeInfo 1.0
import QtQuick.Window 2.2

ItemDelegate {
    id: delegate
    height: 90
    width: ListView.view.width
    clip: true
    property var listView: ListView.view
    
    Cursor {}
    
    RowLayout {
        clip: true
        spacing: 10
        width: delegate.width - 20
        height: banner.height
        anchors.centerIn: parent
        Item {
            Layout.preferredWidth: 133
            Layout.preferredHeight: 75
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Image {
                id: banner
                source: imageUrl
                anchors.fill: parent
                visible: false
                fillMode: Image.PreserveAspectCrop
                sourceSize: Qt.size(width * Screen.devicePixelRatio,
                                    width * Screen.devicePixelRatio)
            }
            OpacityMask {
                anchors.fill: banner
                source: banner
                maskSource: Rectangle {
                    width: banner.width
                    height: banner.width
                    radius: 4
                }
            }
        }
        ColumnLayout {
            spacing: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            Label {
                text: title
                wrapMode: Label.WordWrap
                Layout.fillWidth: true
                font.pixelSize: 12
                maximumLineCount: 3
                elide: Label.ElideRight
            }
            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                wrapMode: Label.NoWrap
                font.pixelSize: 11
                maximumLineCount: 2
                elide: Label.ElideRight
                verticalAlignment: Label.AlignTop
                color: Settings.theme === 'Dark' ? "#949494" : "#848484"
                Behavior on color { SmoothColorAnimation {} }
                text: channelTitle + '\n'
                + Utils.viewString(statistics.viewCount) + ' \u2022 '
                + Utils.fromNow(date)
            }
        }
    }
    
    onClicked: listView.videoOpened(listView.model.get(index))
}
