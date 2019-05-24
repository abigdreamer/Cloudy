import QtQuick 2.9
import QtQuick.Controls 2.3
import Application 1.0

Label {
    id: view
    text: watchPane.video ? Utils.viewString(watchPane.video.statistics.viewCount) : "NaN"
    wrapMode: Label.NoWrap
    font.pixelSize: 14
    maximumLineCount: 1
    elide: Label.ElideRight
    anchors.right: stats.left
    anchors.left: title.left
    anchors.top: title.bottom
    anchors.topMargin: 3
    color: Settings.theme === 'Dark' ? "#949494" : "#848484"
    Behavior on color { SmoothColorAnimation {} }
}
