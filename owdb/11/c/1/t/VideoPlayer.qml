import QtQuick 2.9
import QtMultimedia 5.8

Item {
    id: root

    Video {
        id: video
        anchors.fill: parent
    }

    Dock {
        id: dock
        videoPlayer: video
        anchors.fill: video
    }

    property alias dock: dock
    property alias player: video
}
