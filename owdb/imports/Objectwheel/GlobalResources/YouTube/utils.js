.pragma library
.import YouTube 1.0 as YouTube

function toTrendsUrl(countryCode) {
    return YouTube.Constants.apiUrl + 'videos' +
        '?part=snippet,statistics,player&chart=mostPopular&maxResults=32' +
        '&key=' + YouTube.Constants.apiKey +
        '&regionCode=' + countryCode
}

function toChannelsUrl(responses) {
    var res = YouTube.Constants.apiUrl + 'channels' +
        '?part=snippet,statistics' +
        '&key=' + YouTube.Constants.apiKey + '&id='
    for (var i = 0; i < responses.length; ++i)
        res += responses[i].channelId + ','
    return res.slice(0, -1)
}

function toCommentsUrl(videoId, orderByTime) {
    return YouTube.Constants.apiUrl + 'commentThreads' +
        '?part=snippet&maxResults=20&textFormat=plainText' +
        '&key=' + YouTube.Constants.apiKey +
        '&videoId=' + videoId +
        '&order=' + (orderByTime ? 'time' : 'relevance')
}

function toTrendsObject(response) {
    return {
        "id": response.id,
        "channelId": response.snippet.channelId,
        "channelStatistics": null,
        "channelImageUrl": null,
        "channelDescription": null,
        "channelTitle": response.snippet.channelTitle,
        "title": response.snippet.localized.title,
        "description": response.snippet.localized.description,
        "imageUrl": response.snippet.thumbnails.high.url,
        "statistics": response.statistics,
        "date": new Date(response.snippet.publishedAt)
    }
}

function toCommentsObject(response) {
    return {
        "authorDisplayName": response.snippet.topLevelComment.snippet.authorDisplayName,
        "authorProfileImageUrl": response.snippet.topLevelComment.snippet.authorProfileImageUrl.replace("s28-c", "s80-c"),
        "authorChannelUrl": response.snippet.topLevelComment.snippet.authorChannelUrl,
        "textDisplay": response.snippet.topLevelComment.snippet.textDisplay,
        "likeCount": response.snippet.topLevelComment.snippet.likeCount,
        "totalReplyCount": response.snippet.totalReplyCount,
        "publishedAt": new Date(response.snippet.topLevelComment.snippet.publishedAt),
        "updatedAt": new Date(response.snippet.topLevelComment.snippet.updatedAt)
    }
}

function toChannelImageUrlList(response) {
    var finalList = []
    for (var i = 0; i < response.items.length; ++i) {
        var entry = response.items[i]
        finalList[entry.id] = {
            "channelDescription": entry.snippet.description,
            "channelStatistics" : entry.statistics,
            "channelImageUrl" : entry.snippet.thumbnails.medium.url
        }
    }
    return finalList
}

function toCommentsList(response) {
    var finalList = []
    for (var i = 0; i < response.items.length; ++i)
        finalList.push(toCommentsObject(response.items[i]))
    return finalList
}

function toTrendsList(response) {
    var finalList = []
    for (var i = 0; i < response.items.length; ++i)
        finalList.push(toTrendsObject(response.items[i]))
    return finalList
}
