import QtQuick 2.9
import QtQuick.Controls 2.3

SwipeView {
    id: swipeView
    anchors.fill: parent
    interactive: false
    clip: true
    currentIndex: applicationWindow.weatherBar.currentIndex
}
