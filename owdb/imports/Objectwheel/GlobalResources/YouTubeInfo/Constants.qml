pragma Singleton
import QtQuick 2.6

QtObject {
    readonly property string apiKey: "AIzaSyBYWj7JvlN38JTnJuA33X_v-80fP_jIl3o"
    readonly property string apiUrl: "https://www.googleapis.com/youtube/v3/"
    readonly property string videoApiUrl: "http://api.objectwheel.com:3000/ydl"
    readonly property var speeds: [ "0.25", "0.5", "0.75", "Normal", "1.25", "1.5", "1.75", "2", ]
}
