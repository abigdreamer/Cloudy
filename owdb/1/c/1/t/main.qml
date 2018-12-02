import QtQuick 2.7
import QtQuick.Controls 2.2

SwipeView {
    y: -6
    x: 7
    id: swipeView
    anchors.fill: parent
    interactive: false
    clip: true
    currentIndex: applicationWindow.tabBar.currentIndex
}
