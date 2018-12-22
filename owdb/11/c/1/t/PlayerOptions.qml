ScrollView {
                id: scrollView
                anchors.centerIn: parent
                Column {
                    Repeater {
                        model: qualities
                        delegate: ItemDelegate {
                            id: delegate
                            width: 100
                            height: 20
                            leftPadding: 0
                            rightPadding: 0
                            topPadding: 0
                            bottomPadding: 0
                            anchors.right: parent.right
                            autoExclusive: true
                            checked: qualityText.text === quality
                            onClicked: quality = qualityText.text
                            Row {
                                Text {
                                    verticalAlignment: Text.AlignVCenter
                                    visible: delegate.checked
                                    text: "\u2713"
                                }
                                Text {
                                    id: qualityText
                                    text: qualities[qualities.length - index - 1]
                                    color: delegate.down ? "#17a81a" : "#21be2b"
                                    verticalAlignment: Text.AlignVCenter
                                }
                                Text {
                                    text: qualityText.text === "720p" ? "HD" : ""
                                    color: "#FC0D1B"
                                    font.pixelSize: 10
                                    font.weight: Font.Medium
                                    verticalAlignment: Text.AlignTop
                                }
                            }
                        }
                    }
                }
            }