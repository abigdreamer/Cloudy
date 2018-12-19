import QtQuick 2.9
import QtQuick.Controls 2.2
import Application 1.0

ListView {
    id: videoSearchList
    clip: true
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: searchField.bottom
    anchors.bottom: parent.bottom
    anchors.topMargin: 10
    cacheBuffer: 9000
    delegate: YouTubeSearchDelegate {}
    model: ListModel {}
    footer: Label {
        text: qsTr("LOAD MORE")
        font.weight: Font.Medium
        font.pixelSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
        visible: videoSearchList.count > 0 && nextPageToken
        height: 24
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: loadMoreSearchResults()
        }
    }
        
    ScrollBar.horizontal: ScrollBar
    { policy: ScrollBar.AlwaysOff }
    ScrollBar.vertical: ScrollBar
    { policy: ScrollBar.AsNeeded; interactive: false }
    
    property string nextPageToken
    
    signal loadMoreSearchResults()
    signal videoOpened(var listElement)
}
