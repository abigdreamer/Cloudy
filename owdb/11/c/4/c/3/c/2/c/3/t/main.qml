import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0

Label {
    id: channelSubs
    text: watchPane.video
          ? Utils.subsString(watchPane.video.channelStatistics.subscriberCount)
          : "NaN"
    wrapMode: Label.NoWrap
    elide: Text.ElideRight
    font.pixelSize: 13
    maximumLineCount: 1
    color: Settings.theme === 'Dark' ? "#949494" : "#848484"
    Behavior on color { SmoothColorAnimation {} }
    anchors.left: channelImage.right
    anchors.leftMargin: 10
    anchors.top: channelTitle.bottom
    anchors.topMargin: 3
}