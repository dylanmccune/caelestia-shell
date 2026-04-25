pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

QtObject {
    id: root

    property var history: []
    property bool loaded: false

    function load(): void {
        loadProc.running = true;
    }

    readonly property Process loadProc: Process {
        command: ["cliphist", "list"]
        stdout: StdioCollector {
            onStreamFinished: {
                console.log("Clipboard list finished, length: " + text.length);
                const lines = text.trim().split("\n");
                const parsed = [];
                for (const line of lines) {
                    const parts = line.split(/\t/);
                    if (parts.length >= 2) {
                        parsed.push({
                            id: parts[0],
                            content: parts[1]
                        });
                    } else {
                        const match = line.match(/^(\d+)\s+(.*)$/);
                        if (match) {
                            parsed.push({
                                id: match[1],
                                content: match[2]
                            });
                        }
                    }
                }
                root.history = parsed;
                root.loaded = true;
                console.log("Parsed " + root.history.length + " clipboard items");
            }
        }
    }

    function query(search: string): var {
        const prefix = `${Config.launcher.actionPrefix}clip `;
        if (search.startsWith(prefix))
            search = search.slice(prefix.length);
        
        if (!search) return history;
        const words = search.toLowerCase().split(" ").filter(w => w.length > 0);
        
        return history.filter(h => {
            const content = h.content.toLowerCase();
            return words.every(word => content.includes(word));
        });
    }

    function select(item: var, list: Item): void {
        Quickshell.execDetached(["sh", "-c", `cliphist decode ${item.id} | wl-copy`]);
        list.visibilities.launcher = false;
    }

    function clear(): void {
        Quickshell.execDetached(["cliphist", "wipe"]);
        history = [];
        console.log("Clipboard history wiped");
    }
}
