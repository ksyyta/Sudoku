import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Rectangle {

    Text {
        id: sudoku_label
        text: "SUDOKU"
        color: settings.color_background
        font.family: "Comic sans ms"
        font.pixelSize: 120
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50
    }

    ColumnLayout {
        RadioButton {
            text: qsTr("Blue")
            checked: settings.color_scheme == 0
            onClicked: {
                settings.color_scheme = 0;
                settings.color_background = "#4C5451";
                settings.color_background_2 = "#BAD4CA";
                settings.color_foreground = "#90A39C";
                settings.color_foreground_2 = "#66DB9B";
            }
        }
        RadioButton {
            text: qsTr("Pink")
            checked: settings.color_scheme == 1
            onClicked: {
                settings.color_scheme = 1;
                settings.color_background = "#756A66";
                settings.color_background_2 = "#F7A98D";
                settings.color_foreground = "#F5DDD5";
                settings.color_foreground_2 = "#755043";
            }
        }
        RadioButton {
            text: qsTr("Green")
            checked: settings.color_scheme == 2
            onClicked: {
                settings.color_scheme = 2;
                settings.color_background = "#385C29";
                settings.color_background_2 = "#E3F5DC";
                settings.color_foreground = "#85DB63";
                settings.color_foreground_2 = "#52614C";
            }
        }
    }

    ColumnLayout {
        spacing: 10
        width: 400
        anchors.top: sudoku_label.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
            id: startgame
            Layout.fillWidth: true
            Layout.preferredHeight: 90
            onClicked: {
                parent.parent.visible = false
                easyhard.visible = true
                game.table.activeIndex = -1
            }

            contentItem: Text {
                text: "Start Game"
                color: settings.color_background_2
                font.family: "Comic sans ms"
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: settings.color_background
                radius: 2
            }
        }

        Button {
            Layout.fillWidth: true
            Layout.preferredHeight: 90
            onClicked: {
                parent.parent.visible = false
                records_rect.visible = true
                game.table.activeIndex = -1
            }

            contentItem: Text {
                text: "Records"
                color: settings.color_background_2
                font.family: "Comic sans ms"
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: settings.color_background
                radius: 2
            }
        }

        Button {
            id: exit
            Layout.fillWidth: true
            Layout.preferredHeight: 90
            onClicked: close()

            contentItem: Text {
                text: "Exit"
                color: settings.color_background_2
                font.family: "Comic sans ms"
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: settings.color_background
                radius: 2
            }
        }
    }
}
