.pragma library
.import YouTube 1.0 as YouTube

function toTrendsUrl(countryCode) {
    return  YouTube.Constants.apiUrl +
        '?part=snippet&chart=mostPopular&maxResults=32' +
        '&key=' + YouTube.Constants.apiKey +
        '&regionCode=' + countryCode
}

function toStatisticsUrl(countryCode) {
    return  YouTube.Constants.apiUrl +
        '?part=statistics&chart=mostPopular&maxResults=32' +
        '&key=' + YouTube.Constants.apiKey +
        '&regionCode=' + countryCode
}

function toTrendsObject(response, statistics) {
    return {
        "id": response.id,
        "channelTitle": response.snippet.channelTitle,
        "title": response.snippet.localized.title,
        "description": response.snippet.localized.description,
        "imageUrl": response.snippet.thumbnails.high.url,
        "statistics": statistics[response.id],
        "date": new Date(response.snippet.publishedAt)
    }
}

function toTrendsList(response) {
    var finalList = []
    for (var i = 0; i < response.items.length; ++i)
        finalList.push(response.items[i])
    return finalList
}

function toStatisticsList(response) {
    var finalList = {}
    for (var i = 0; i < response.items.length; ++i) {
        var stat = response.items[i]
        finalList[stat.id] = stat.statistics
    }
    return finalList
}
