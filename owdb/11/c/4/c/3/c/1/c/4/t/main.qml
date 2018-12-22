import QtQuick 2.8
import QtQuick.Window 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import Application 1.0
import Application.Resources 1.0
    
Row {
    id: stats
    clip: true
    anchors.right: arrowDown.right
    anchors.verticalCenter: view.verticalCenter
    anchors.verticalCenterOffset: 5
    spacing: 8
    Column {
        spacing: 2
        TintImage {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 16
            height: 16
            icon.source: Resource.images.other.like
            tintColor: Settings.theme === 'Dark' ? "#949494" : "#848484"
            Behavior on tintColor { SmoothColorAnimation {} }
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: watchPane.video
                  ? Utils.likeString(watchPane.video.statistics.likeCount)
                  : "NaN"
            wrapMode: Label.NoWrap
            font.pixelSize: 12
            maximumLineCount: 1
            elide: Label.ElideRight
            color: Settings.theme === 'Dark' ? "#949494" : "#848484"
            Behavior on color { SmoothColorAnimation {} }
        }
    }
    Column {
        spacing: 2
        TintImage {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 16
            height: 16
            icon.source: Resource.images.other.dislike
            tintColor: Settings.theme === 'Dark' ? "#949494" : "#848484"
            Behavior on tintColor { SmoothColorAnimation {} }
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: watchPane.video
                  ? Utils.likeString(watchPane.video.statistics.dislikeCount)
                  : "NaN"
            wrapMode: Label.NoWrap
            font.pixelSize: 12
            maximumLineCount: 1
            elide: Label.ElideRight
            color: Settings.theme === 'Dark' ? "#949494" : "#848484"
            Behavior on color { SmoothColorAnimation {} }
        }
    }
}
