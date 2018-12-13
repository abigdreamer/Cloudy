import QtQuick 2.9
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0

Page {
    id: videosSection
    width: 342
    height: 608
    Component.onCompleted: VideosSectionJS.videosSection_onCompleted()
    title: qsTr("Videos")
}
