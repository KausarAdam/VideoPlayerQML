import QtQuick
import QtMultimedia
import QtQuick.Dialogs

// main app window
Window {
    property alias videoAlias: video // can access video from outside window
    width: 640
    height: 480
    visible: true // make it visible
    title: qsTr("Video Player - Kawthar Adam") // window title

    // menu bar
    MenuBar{
        z: 99 // to stack it on top of everything
        // open file button
        Rectangle {
            width: 80
            color: "dark blue"
            height: parent.height
            border.color: "white"

            anchors.centerIn: parent // center of menu bar

            Text {
                anchors.fill: parent
                text: "Open File"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                // open file dialog when button is clicked
                MouseArea {
                    anchors.fill: parent
                    onClicked: fileDialog.open()
                }
            }
            // file dialog to open video file
            FileDialog {
                id: fileDialog
                nameFilters: ["Video files (*.mp4 *.avi *.mkv)"] // only video files with these extensions
                onAccepted: {
                    video.play() // play when video is accepted
                }
            }
        }
    }

    // video player space
    Rectangle {
        color: video.hasVideo ? "black" : "white" // when no video -> white, else -> black
        anchors.fill: parent
        // video element
        Video {
            id: video
            anchors.fill: parent // fill space
            fillMode: VideoOutput.PreserveAspectFit // display video and maintain aspect ratio
            source: fileDialog.selectedFile // video file to be played
        }
    }

    // playback controls at the bottom
    Rectangle {
        height: 80
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: "black"

        // progress bar and slider
        MySlider {
            id: slider
            maximum: video.duration // max is the video duration
            minimum: 0 // from beginnign
            value: video.position // current
        }

        PlaybackMenu {
            anchors.centerIn: parent
        }

    }
}
