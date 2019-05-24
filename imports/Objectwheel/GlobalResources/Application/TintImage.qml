import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtQuick.Window 2.3

Item {
    Image {
        id: border
        visible: false
        source: image.source
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        sourceSize: image.sourceSize
    }
    ColorOverlay {
        id: overlayBorder
        anchors.fill: border
        source: border
        visible: borderWidth > 0
    }
    Image {
        id: image
        visible: false
        anchors.fill: parent
        anchors.margins: borderWidth
        fillMode: Image.PreserveAspectFit
        sourceSize: Qt.size(width * Screen.devicePixelRatio,
                            height * Screen.devicePixelRatio)
    }
    ColorOverlay {
        id: overlay
        anchors.fill: image
        source: image
    }
    property real borderWidth: 0
    property alias borderColor: overlayBorder.color
    property alias tintColor: overlay.color
    property alias icon: image
}
