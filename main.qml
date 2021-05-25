import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.0
import QtQml.Models 2.15

Window {
    width: 700
    height: 600
    visible: true
    title: qsTr("SUDOKU")
    color: settings.color_background

    property bool isGameGoing: true
    property int errorCount: 0

    Settings {
        id: settings
        property color color_background: "#4C5451"
        property color color_background_2: "#BAD4CA"
        property color color_foreground: "#90A39C"
        property color color_foreground_2: "#66DB9B"
        property int color_scheme: 0

        property var recordsList: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }

    StartPage {
        id: startpage
        anchors.fill: parent
        color: settings.color_background_2
        z: 10
    }

    Records {
        id: records
        anchors.fill: parent
        anchors.verticalCenter: parent.verticalCenter
        color: settings.color_background_2
        z: 10
        visible: false
    }

    EasyHard {
        id: easyhard
        anchors.fill: parent
        anchors.verticalCenter: parent.verticalCenter
        color: settings.color_background_2
        z:10
        visible: false
    }

    Game {
        id: game
        anchors.fill: parent
    }

    Timer {
        property int count: 0

        id: timer_kus
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            count += 1
            var min = Math.floor(count / 60).toString().padStart(2, "0")
            var sec = (count % 60).toString().padStart(2, "0")
            game.time.text = "Time: " + min + ":" + sec
        }
     }
}



