import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.settings 1.0

import Sudoku 1.0

Window {
    width: 700
    height: 600
    visible: true
    title: qsTr("SUDOKU")
    color: settings.color_background

    property bool isGameGoing: true

    Settings {
        id: settings
        property color color_background: "#4C5451"
        property color color_background_2: "#BAD4CA"
        property color color_foreground: "#90A39C"
        property color color_foreground_2: "#66DB9B"
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

    Rectangle {
        enabled: isGameGoing
        id: field
        width: 414
        height: 414
        color: settings.color_background
        border.color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 80
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            color: "black"
            width: 3
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
        }

        Rectangle {
            color: "black"
            height: 3
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        TableView {
            property int activeIndex: 82
            property int activeColumn: 9
            property int activeRow: 9
            property bool isLegal: true
            id: table
            anchors.fill: parent
            interactive: false
            columnSpacing: 0
            rowSpacing: 0
            model: Sudoku.model

            delegate: Rectangle {
                implicitWidth: parent.width / 9
                implicitHeight: parent.height / 9
                color: index === table.activeIndex ? (table.isLegal ? settings.color_background_2 : "red") : "transparent"
                Text {
                    text: model.num === 0 ? "" : model.num
                    color: settings.color_foreground
                    font.pixelSize: 42
                    font.bold: true
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Rectangle {
                    color: "black"
                    width: column % 3 ? 1 : 3
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                }
                Rectangle {
                    color: "black"
                    height: row % 3 ? 1 : 3
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Sudoku.SelectSquare(column, row);
                        table.isLegal = true;
                        table.activeIndex = index;
                        table.activeColumn = column;
                        table.activeRow = row;
                    }
                }
            }
        }
    }

    Button {
        id: back_button
        anchors.bottom: field.top
        anchors.left: field.left
        anchors.bottomMargin: 10
        icon.source: "qrc:/resources/back-arrow.png"
        icon.width: 40
        icon.height: 40
        onClicked: {
            isGameGoing = false
            startpage.visible = true
        }
        background: Rectangle {
            implicitWidth: 40
            implicitHeight: 40
            color: settings.color_foreground
            radius: 2
        }
    }

    Timer {
        id: timer_kus
        property int count: 0
        interval: 1000; running: false; repeat: true
        onTriggered: {
            count += 1
            var min = Math.floor(count / 60).toString().padStart(2, "0")
            var sec = (count % 60).toString().padStart(2, "0")
            time.text = "Time: " + min + ":" + sec
        }
     }

    Text {
        id: time
        color: settings.color_foreground
        anchors.left: back_button.right
        anchors.bottom: back_button.bottom
        anchors.leftMargin: 10
        font.pointSize: 20
     }

    RowLayout {
        enabled: isGameGoing
        anchors.top: field.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: field.horizontalCenter

        Repeater {
            model: 9

            Button {
                id: control
                Layout.minimumHeight: 50
                Layout.minimumWidth: 45
                onClicked: {
                    table.isLegal = Sudoku.SetValue(table.activeColumn, table.activeRow, index + 1)

                }

                contentItem: Text {
                    text: index + 1
                    font.family: "aril black"
                    font.pixelSize: 50
                    color: settings.color_background_2
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    color: "transparent"
                    radius: 2
                }
            }
        }
    }

    ColumnLayout {
        enabled: isGameGoing
        anchors.left: field.right
        anchors.verticalCenter: field.verticalCenter
        anchors.leftMargin: 20
        spacing: 30

        Button {
            onClicked: Sudoku.Hint()
            ToolTip.delay: 100
            ToolTip.visible:  hovered
            ToolTip.text: qsTr("Hint")
            icon.source: "qrc:/resources/lamp.png"
            icon.color: settings.color_foreground
            icon.width: 40
            icon.height: 40
            background: Rectangle {
                implicitWidth: 150
                implicitHeight: 50
                color: "transparent"
                radius: 2
            }
        }

        Button {
            icon.source: "qrc:/resources/eraser.png"
            ToolTip.delay: 100
            ToolTip.visible:  hovered
            ToolTip.text: qsTr("Clear")
            icon.color: settings.color_foreground
            icon.width: 40
            icon.height: 40
            background: Rectangle {
                implicitWidth: 150
                implicitHeight: 50
                color: "transparent"
                radius: 2
            }
        }
        Button {
            onClicked: Sudoku.Solve()
            ToolTip.delay: 100
            ToolTip.visible:  hovered
            ToolTip.text: qsTr("Solve")
            icon.source: "qrc:/resources/pen.png"
            icon.color: settings.color_foreground
            icon.width: 40
            icon.height: 40
            background: Rectangle {
                implicitWidth: 150
                implicitHeight: 50
                color: "transparent"
                radius: 2
            }
        }

        Button {
            onClicked: {
                timer_kus.count = 0
                timer_kus.restart()
                Sudoku.Clear()
            }
            icon.source: "qrc:/resources/repeat.png"
            ToolTip.delay: 100
            ToolTip.visible:  hovered
            ToolTip.text: qsTr("Refresh")
            icon.color: settings.color_foreground
            icon.width: 40
            icon.height: 40
            background: Rectangle {
                implicitWidth: 150
                implicitHeight: 50
                color: "transparent"
                radius: 2
            }
        }
    }
}



