import QtQuick 2.9
import QtQuick.Controls 2.3

SwipeView {
    id: swipeView
    anchors.fill: parent
    currentIndex: tabBar.bar.currentIndex
    interactive: false
    clip: true
}
