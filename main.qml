import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.0
import QtQml.Models 2.15

Window {
    id: main
    width: 700
    height: 600
    visible: true
    title: qsTr("SUDOKU")
    color: settings.color_background

    property string datastore: ""
    property bool isGameGoing: true
    property int errorCount: 0

    Settings {
        id: settings
        property color color_background: "#4C5451"
        property color color_background_2: "#BAD4CA"
        property color color_foreground: "#90A39C"
        property color color_foreground_2: "#66DB9B"
        property int color_scheme: 0
        property alias datastore: main.datastore

        property var recordsList: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }

    StartPage {
        id: startpage
        anchors.fill: parent
        color: settings.color_background_2
        z: 10
    }

    Rectangle {
        id: records_rect
        anchors.fill: parent
        anchors.verticalCenter: parent.verticalCenter
        color: settings.color_background_2
        z: 10
        visible: false

        Text {
            text: "Records"
            color: settings.color_background
            font.family: "Comic sans ms"
            font.pixelSize: 120
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 5
        }

        Button {
            id: back_bbutton
            anchors.top: parent.top
            anchors.left: parent.left
            icon.source: "qrc:/resources/back-arrow.png"
            icon.width: 40
            icon.height: 40
            onClicked: {
                parent.visible = false;
                startpage.visible = true;
            }
            background: Rectangle {
                implicitWidth: 40
                implicitHeight: 40
                color: settings.color_foreground
                radius: 2
            }
        }

        ListView {
            id: view
            anchors.centerIn: parent
            height: parent.height / 2
            width: parent.width / 2
            model: ListModel {
                id: dataModel
//                ListElement {
//                    value: 0
//                    easy: true
//                }
            }
            delegate: RowLayout {
                spacing: 10
                Text {
                    text: (index + 1) + ") "
                    color: "black"
                    font.pointSize: 20
                }
                Text {
                    text: Math.floor(value / 60).toString().padStart(2, "0") + ":" + (value % 60).toString().padStart(2, "0")
                    color: "black"
                    font.pointSize: 20
                    anchors.right: parent.right
                    anchors.rightMargin: -106
                }
                Text {
                    text: easy ? "easy" : "hard"
                    color: "black"
                    font.pointSize: 20
                }
            }
        }
    }

    Component.onCompleted: {
        if (datastore) {
            dataModel.clear()
            var datamodel = JSON.parse(datastore)
            for (var i = 0; i < datamodel.length; ++i) dataModel.append(datamodel[i])
        }
    }

    onClosing: {
        var datamodel = []
        for (var i = 0; i < dataModel.count; ++i) datamodel.push(dataModel.get(i))
        datastore = JSON.stringify(datamodel)
    }

    EasyHard {
        id: easyhard
        anchors.fill: parent
        anchors.verticalCenter: parent.verticalCenter
        color: settings.color_background_2
        z: 10
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



