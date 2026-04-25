import qs.components
import qs.components.controls
import qs.services
import qs.config
import Caelestia
import Quickshell
import QtQuick
import QtQuick.Layouts
import "../services"

Item {
    id: root

    required property var list
    readonly property string searchText: list.search.text.split(" ").slice(1).join(" ")

    implicitHeight: 400
    
    anchors.left: parent?.left
    anchors.right: parent?.right
    
    readonly property var filteredEmojis: Emojis.search(searchText)

    GridView {
        id: grid
        anchors.fill: parent
        anchors.margins: Appearance.padding.normal
        cellWidth: width / 8
        cellHeight: cellWidth
        model: filteredEmojis
        clip: true
        
        highlight: StyledRect {
            radius: Appearance.rounding.normal
            color: Colours.palette.m3onSurface
            opacity: 0.08
        }
        
        delegate: Item {
            width: grid.cellWidth
            height: grid.cellHeight
            
            StateLayer {
                anchors.fill: parent
                radius: Appearance.rounding.normal
                
                function onClicked(): void {
                    Quickshell.execDetached(["wl-copy", modelData.glyph]);
                    root.list.visibilities.launcher = false;
                }
            }
            
            StyledText {
                anchors.centerIn: parent
                width: parent.width - Appearance.padding.normal
                height: parent.height - Appearance.padding.normal
                
                text: modelData.glyph
                font.pointSize: Appearance.font.size.extraLarge
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                
                fontSizeMode: Text.Fit
                minimumPointSize: Appearance.font.size.small
                maximumLineCount: 1
                elide: Text.ElideNone
            }
        }
        
        StyledScrollBar.vertical: StyledScrollBar {
            flickable: grid
        }
    }
    
    function onClicked(): void {
        if (grid.currentIndex >= 0 && grid.currentIndex < filteredEmojis.length) {
            Quickshell.execDetached(["wl-copy", filteredEmojis[grid.currentIndex].glyph]);
            root.list.visibilities.launcher = false;
        }
    }

    function incrementCurrentIndex(): void {
        grid.moveCurrentIndexDown();
    }

    function decrementCurrentIndex(): void {
        grid.moveCurrentIndexUp();
    }
}
