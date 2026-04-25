import "../services"
import qs.components
import qs.services
import qs.config
import Quickshell
import QtQuick

Item {
    id: root

    required property var modelData
    required property var list

    function onClicked(): void {
        Clipboard.select(root.modelData, root.list);
    }

    implicitHeight: Config.launcher.sizes.itemHeight

    anchors.left: parent?.left
    anchors.right: parent?.right

    StateLayer {
        radius: Appearance.rounding.normal

        function onClicked(): void {
            Clipboard.select(root.modelData, root.list);
        }
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: Appearance.padding.larger
        anchors.rightMargin: Appearance.padding.larger
        anchors.margins: Appearance.padding.smaller

        MaterialIcon {
            id: icon
            text: "content_paste"
            font.pointSize: Appearance.font.size.large
            anchors.verticalCenter: parent.verticalCenter
        }

        StyledText {
            id: content
            anchors.left: icon.right
            anchors.leftMargin: Appearance.spacing.normal
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: root.modelData?.content ?? ""
            font.pointSize: Appearance.font.size.normal
            elide: Text.ElideRight
            maximumLineCount: 1
        }
    }
}
