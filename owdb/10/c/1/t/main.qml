import QtQuick 2.7
import QtQuick.Controls 2.2
import Application 1.0

ListView {
    y: 0
    x: 0
    id: trendsList
    clip: true
    anchors.fill: parent
    delegate: TrendsListDelegate {}
    model: ListModel {}
}
