import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Rectangle {

    Text {
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
            checked: true
            onClicked: {
                settings.color_background = "#4C5451";
                settings.color_background_2 = "#BAD4CA";
                settings.color_foreground = "#90A39C";
                settings.color_foreground_2 = "#66DB9B";
            }
            text: qsTr("First")
        }
        RadioButton {
            text: qsTr("Second")
            onClicked: {
                settings.color_background = "#756A66";
                settings.color_background_2 = "#F7A98D";
                settings.color_foreground = "#F5DDD5";
                settings.color_foreground_2 = "#755043";
            }
        }
        RadioButton {
            text: qsTr("Third")
            onClicked: {
                settings.color_background = "#385C29";
                settings.color_background_2 = "#E3F5DC";
                settings.color_foreground = "#85DB63";
                settings.color_foreground_2 = "#52614C";
            }
        }
    }

    Button {
        height: 90
        width: 400
        id: startgame
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.leftMargin: 150
        onClicked: {
            parent.visible = false
            easyhard.visible = true
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

        Button {
            height: 90
            width: 400
            id: exit
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 200
            onClicked: close(Window)

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

        Button {
            height: 90
            width: 400
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 101
            onClicked: {
                parent.visible = false
                records.visible = true
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
    }
}
