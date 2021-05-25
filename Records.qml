import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {

    Text {
        text: "Records"
        color: settings.color_background
        font.family: "Comic sans ms"
        font.pixelSize: 120
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50
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
        anchors.centerIn: parent
        height: parent.height / 2
        width: parent.width / 2
        model: 10
        delegate: RowLayout {
            spacing: 10
            Text {
                text: settings.recordsList[index]
                color: "black"
                font.pointSize: 20
            }
            Text {
                text: (index + 1) + "."
                color: "black"
                font.pointSize: 20
            }
        }
    }
}
