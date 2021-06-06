import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

import Sudoku 1.0

Item {
    property alias time: time
    property alias table: table
    property bool hintAvailable: true
    property bool isEasy: true

    Rectangle {
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
            z: 2
        }

        Rectangle {
            color: "black"
            height: 3
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            z: 2
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
                color: index === table.activeIndex ? (table.isLegal ? settings.color_background_2 : "#ac0020") : "transparent"
                Text {
                    text: model.num === 0 ? "" : model.num
                    color: model.const ? "black" : settings.color_foreground
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
        enabled: isGameGoing
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

    Text {
        id: time
        color: settings.color_foreground
        anchors.left: back_button.right
        anchors.bottom: back_button.bottom
        anchors.leftMargin: 10
        font.pointSize: 20
    }

    Label {
        text: "Mistakes: " + errorCount + " / 3"
        color: settings.color_foreground
        anchors.right: field.right
        anchors.bottom: field.top
        anchors.bottomMargin: 10
        font.pointSize: 20
    }

    RowLayout {
        anchors.top: field.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: field.horizontalCenter
        enabled: isGameGoing

        Repeater {
            model: 9

            Button {
                Layout.minimumHeight: 50
                Layout.minimumWidth: 45
                onClicked: {
                    table.isLegal = Sudoku.SetValue(table.activeColumn, table.activeRow, index + 1);
                    if (!table.isLegal)
                        errorCount += 1;
                    if (errorCount >= 3) {
                        table.activeIndex = -1
                        isGameGoing = false;
                        timer_kus.count = 0
                        timer_kus.stop()
                    }
                    if (Sudoku.Filled()) {
                        var tmp = timer_kus.count;
                        for (var i = 0; i < 9; i++) {
                            console.log(i)
                            if (!dataModel.get(i)) {
                                dataModel.set(i, {"value": tmp, "easy": isEasy})
                                break;
                            }
                            if (tmp < dataModel.get(i).value) {
                                var tmp_2 = dataModel.get(i).value;
                                dataModel.set(i, {"value": tmp, "easy": isEasy})
                                tmp = tmp_2;
                            }
                        }
                        table.activeIndex = -1
                        timer_kus.count = 0
                        timer_kus.stop()
                        errorCount = 0
                        hintAvailable = true
                        isGameGoing = false;
                    }
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
        property int buttonWidth: 60
        property int buttonHeight: 60

        anchors.left: field.right
        anchors.verticalCenter: field.verticalCenter
        anchors.leftMargin: 60
        spacing: 30
        enabled: isGameGoing

        IconButton {
            Layout.preferredWidth: parent.buttonWidth
            Layout.preferredHeight: parent.buttonHeight
            enabled: hintAvailable
            onClicked: {
                if (hintAvailable) {
                    Sudoku.Hint()
                    hintAvailable = false;
                }
            }
            ToolTip.text: qsTr("Hint")
            icon.source: "qrc:/resources/lamp.png"
        }
        IconButton {
            Layout.preferredWidth: parent.buttonWidth
            Layout.preferredHeight: parent.buttonHeight
            onClicked: Sudoku.Clear(table.activeColumn, table.activeRow)
            ToolTip.text: qsTr("Clear")
            icon.source: "qrc:/resources/eraser.png"
        }
        IconButton {
            Layout.preferredWidth: parent.buttonWidth
            Layout.preferredHeight: parent.buttonHeight
            onClicked: Sudoku.Solve()
            ToolTip.text: qsTr("Solve")
            icon.source: "qrc:/resources/pen.png"
        }
        IconButton {
            Layout.preferredWidth: parent.buttonWidth
            Layout.preferredHeight: parent.buttonHeight
            onClicked: {
                table.activeIndex = -1
                timer_kus.count = 0
                timer_kus.restart()
                errorCount = 0
                hintAvailable = true
                Sudoku.Clear()
            }
            ToolTip.text: qsTr("Refresh")
            icon.source: "qrc:/resources/repeat.png"
        }
    }

    Rectangle {
        id: endGameMessage
        visible: !isGameGoing
        anchors.centerIn: parent
        width: 600
        height: 320
        border.width: 4
        border.color: settings.color_foreground
        color: settings.color_background

        ColumnLayout {
            anchors.centerIn: parent
            Button {
                id: restartButton
                Layout.preferredHeight: 50
                Layout.preferredWidth: 150
                contentItem: Text {
                    text: "Restart"
                    color: settings.color_background_2
                    font.family: "Comic sans ms"
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                onClicked: {
                    Sudoku.Clear()
                    isGameGoing = true
                    timer_kus.count = 0
                    timer_kus.restart()
                    errorCount = 0
                    hintAvailable = true
                    table.activeIndex = -1
                }

                background: Rectangle {
                    implicitWidth: 40
                    implicitHeight: 40
                    color: settings.color_foreground
                    radius: 2
                }
            }
            Button {
                id: closeButton
                Layout.preferredHeight: 50
                Layout.preferredWidth: 150
                onClicked: Qt.quit()
                contentItem: Text {
                    text: "Close"
                    color: settings.color_background_2
                    font.family: "Comic sans ms"
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                background: Rectangle {
                    implicitWidth: 40
                    implicitHeight: 40
                    color: settings.color_foreground
                    radius: 2
                }
            }
        }
    }
}
