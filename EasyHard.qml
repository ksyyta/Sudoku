import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

import Sudoku 1.0

Rectangle {

    ColumnLayout {
        width: 300
        spacing: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 130

        Button {
            id: easy
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            onClicked: {
                parent.parent.visible = false
                Sudoku.Restart(false)
                errorCount = 0
                isGameGoing = true
                timer_kus.count = 0
                timer_kus.restart()
            }

            contentItem: Text {
                text: "Easy"
                color: settings.color_background_2
                font.family: "Comic sans ms"
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: settings.color_background
            }
        }

        Button {
            id: hard
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            onClicked: {
                parent.parent.visible = false
                Sudoku.Restart(true)
                errorCount = 0
                isGameGoing = true
                timer_kus.count = 0
                timer_kus.restart()
            }

            contentItem: Text {
                text: "Hard"
                color: settings.color_background_2
                font.family: "Comic sans ms"
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: settings.color_background
            }
        }
    }
}
