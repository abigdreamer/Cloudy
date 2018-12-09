// homePane.js

.import NewsInfo 1.0 as NewsInfo

function homePane_onCompleted() {

}

function newsBalloon_onClicked() {    
     NewsInfo.Fetch.getTopNews('tr', function(val, err) {
        if (err) {
            console.log(err)
            return
        }
        for (var i = 0; i < val.length; ++i) {
            //console.log(val[i].date)
        }
    })
}
