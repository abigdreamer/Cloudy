pragma Singleton
import QtQuick 2.6
import "utils.js" as Utils

QtObject {
    function getTopNews(countryCode, callback) {
        var url = Utils.toTopNewsUrl(countryCode)
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    return callback(null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                if (response.status !== 'ok')
                    return callback(null, "Server returned empty data")

                var newsDatas = Utils.toNewsList(response)
                var newsResponses = []
                for (var i = 0; i < newsDatas.length; i++)
                    newsResponses.push(Utils.toTopNewsObject(newsDatas[i]))
                callback(newsResponses)
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
}
