import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle {

        Button {
            height: 150
            width: 300
            id: easy
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 130
            onClicked: {
                parent.visible = false
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
            height: 150
            width: 300
            id: hard
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 320
            onClicked: {
                parent.visible = false
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
