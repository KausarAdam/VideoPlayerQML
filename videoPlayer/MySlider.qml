import QtQuick

// Root item
Item {
    id: root

    // public
    property double maximum: 10
    property double value:    0
    property double minimum:  0

    // private
    width: parent.width;  height: 10 // default size, same width as parent

    // Slider container/background
    Rectangle {
        width: root.width
        color: 'grey'
        height: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    // pill (draggable portion of the slider)
    Rectangle {
        id: pill
        color: "dark blue"
        x: (value - minimum) / (maximum - minimum) * (root.width - pill.width) // pixels from value
        width: parent.height;  height: width
        border.width: 0.05 * root.height // to make it round
        radius: 0.5 * height
        // current video time on top of pill
        Text {
            id: currentTimeText
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.top
                bottomMargin: 4
            }
            text: formatTime(video.position) // displaying current time
            font.pixelSize: 12
            color: "white"
        }
        // update current video time
        Timer {
            interval: 1000 // update the displayed time every second (1000 milliseconds)
            running: video.playbackState === MediaPlayer.PlayingState // only update when video is playing
            // every second
            onTriggered: {
                currentTimeText.text = formatTime(video.position) // update the displayed time
            }
        }
    }

    // conerts milliseconds to minutes:seconds
    function formatTime(ms) {
        var seconds = Math.floor(ms / 1000)
        var minutes = Math.floor(seconds / 60)
        seconds %= 60
        return minutes + ":" + seconds.toString().padStart(2, '0')
    }

    // interaction with slider
    MouseArea {
        id: mouseArea
        anchors.fill: parent // covers entire item area
        // to allow dragging
        drag {
            target:   pill // to drag pill
            axis:     Drag.XAxis // horizontal dragging
            // boundaries
            maximumX: root.width - pill.width
            minimumX: 0
        }
        // when change is detected in mousearea, call setpixels
        onPositionChanged:  if(drag.active) setPixels(pill.x + 0.5 * pill.width)
    }
    // calculate new value
    function setPixels(pixels) {
        var value = (maximum - minimum) / (root.width - pill.width) * (pixels - pill.width / 2) + minimum // value from pixels
        videoAlias.seek(Math.min(Math.max(minimum, value), maximum))
    }
}
