import QtQuick 2.7
import QtQuick.Window 2.3
import Objectwheel.GlobalResources 1.0

Window {
    id: videosPane
    width: 342
    height: 608
    visible: true
    Component.onCompleted: VideosPaneJS.videosPane_onCompleted()
}