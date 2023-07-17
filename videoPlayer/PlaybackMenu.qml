import QtQuick
import QtQuick.Layouts
import QtMultimedia

Item {
    // control buttons (play and pause)
    RowLayout {
        Layout.alignment: Qt.AlignCenter // horizontal center
        id: controlButtons
        Layout.fillWidth: true // width of parent
        anchors.fill: parent // fills available space

        // play button
        Rectangle {
            id: playButton
            Layout.alignment: Qt.AlignCenter

            Rectangle {
                anchors.centerIn: parent // center
                width: 40
                height: 40
                radius: 50 // circular
                color: "dark blue"
                border.color: "white"

                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "\u25B6" // play triangle
                    font.pixelSize: 20
                    color: "white"
                }
                // interaction
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        video.play() // call play when clicked
                    }
                }

            }
        }

        // pause button
        Rectangle {
            id: pauseButton
            Layout.alignment: Qt.AlignCenter

            Rectangle {
                anchors.centerIn: parent
                width: 40
                height: 40
                radius: 50
                color: "dark blue"
                border.color: "white"

                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text:"\u2016" // pause symbol
                    font.pixelSize: 20
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        video.pause() // call pause when clicked
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "playing"
            when: videoAlias.playbackState == MediaPlayer.PlayingState // video is playing
            PropertyChanges { target: pauseButton; visible: true} // show pause button
            PropertyChanges { target: playButton; visible: false} // hide play button
        },
        State {
            name: "stopped"
            when: videoAlias.playbackState == MediaPlayer.StoppedState // video is stopped
            PropertyChanges { target: pauseButton; visible: false} // hide pause button
            PropertyChanges { target: playButton; visible: true} // show play button
            PropertyChanges { target: slider; value: 0} // set slider to 0 (start)
        },
        State {
            name: "paused"
            when:  videoAlias.playbackState == MediaPlayer.PausedState // video is paused
            PropertyChanges { target: pauseButton; visible: false} // hide pause button
            PropertyChanges { target: playButton; visible: true} // show play button
        }
    ]
}
