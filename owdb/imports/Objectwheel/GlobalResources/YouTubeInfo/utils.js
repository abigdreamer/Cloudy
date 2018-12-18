.pragma library
.import YouTubeInfo 1.0 as YouTubeInfo

function toTrendsUrl(countryCode) {
    return YouTubeInfo.Constants.apiUrl + 'videos' +
        '?part=snippet,statistics&chart=mostPopular&maxResults=42' +
        '&key=' + YouTubeInfo.Constants.apiKey +
        '&regionCode=' + countryCode
}

function toSearchUrl(searchTerm, pageToken) {
    return YouTubeInfo.Constants.apiUrl + 'search' +
        '?part=snippet&maxResults=20' +
        '&key=' + YouTubeInfo.Constants.apiKey +
        '&q=' + encodeURI(searchTerm) +
        (pageToken ? ('&pageToken=' + pageToken) : '')
}

function toChannelsUrl(responses) {
    var res = YouTubeInfo.Constants.apiUrl + 'channels' +
        '?part=snippet,statistics' +
        '&key=' + YouTubeInfo.Constants.apiKey + '&id='
    for (var i = 0; i < responses.length; ++i)
        res += responses[i].channelId + ','
    return res.slice(0, -1)
}

function toCommentsUrl(videoId, orderByTime, pageToken) {
    return YouTubeInfo.Constants.apiUrl + 'commentThreads' +
        '?part=snippet&maxResults=20&textFormat=plainText' +
        '&key=' + YouTubeInfo.Constants.apiKey +
        '&videoId=' + videoId +
        '&order=' + (orderByTime ? 'time' : 'relevance') +
        (pageToken ? ('&pageToken=' + pageToken) : '')
}

function toVideoObject(response) {
    return {
        "id": response.id,
        "channelId": response.snippet.channelId,
        "channelStatistics": null,
        "channelImageUrl": null,
        "channelDescription": null,
        "channelTitle": response.snippet.channelTitle,
        "title": response.snippet.title,
        "description": response.snippet.description,
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

function toVideoList(response) {
    var finalList = []
    for (var i = 0; i < response.items.length; ++i)
        finalList.push(toVideoObject(response.items[i]))
    return finalList
}
