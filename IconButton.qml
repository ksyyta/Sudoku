import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    ToolTip.delay: 100
    ToolTip.visible: hovered
    icon.color: settings.color_foreground
    icon.width: 40
    icon.height: 40
    background: Rectangle {
        color: "transparent"
    }
}
