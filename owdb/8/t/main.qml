import QtQuick 2.9
import QtQuick.Controls 2.3
import Objectwheel.GlobalResources 1.0

Page {
    id: videoSection
    width: 342
    height: 608
    Component.onCompleted: VideoSectionJS.videoSection_onCompleted()
    title: qsTr("Video")
}