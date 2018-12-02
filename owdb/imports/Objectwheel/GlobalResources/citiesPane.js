// citiesPane.js

function citiesPane_onCompleted() {
    addRoundButton.clicked.connect(addRoundButton_onClicked)
    addFinishButton.clicked.connect(addFinishButton_onClicked)
    addCityPane.y = Qt.binding(function() { return addCityPane.height })
}

function addFinishButton_onClicked() {
    addCityPane.y = Qt.binding(function() { return addCityPane.height })
}

function addRoundButton_onClicked() {
    addCityPane.y = 0
    addCityPane.x = 0
}
