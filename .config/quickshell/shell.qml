import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
	id: root

	property color colBg: "#1a1b26"
	property color colFg: "#a9b1d6"
	property color colMuted: "#444b6a"
	property color colCyan: "#0de9d7"
	property color colBlue: "#7aa2f7"
	property color colYellow: "#e0af68"
	property string fontFamily: "JetBrainsMono Nerd Font"
	property int fontSize: 14

	property int battery: 0
	property int brightness: 0
	property var volume: 0
	property var submap: ""

	anchors.top: true
	anchors.left: true
	anchors.right: true
	implicitHeight: 35
	color: root.colBg

	Process {
		id: batProc
		command: ["cat", "/sys/class/power_supply/BAT1/capacity"]
		stdout: StdioCollector {
			onStreamFinished: battery = this.text
		}
		Component.onCompleted: running = true
	}

	Process {
		id: volProc
		command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
				var match = data.match(/Volume:\s*([\d.]+)/)
				if (match) {
					volume = Math.round(parseFloat(match[1]) * 100)
				}
			}
		}
		Component.onCompleted: running = true
	}

	Process {
		id: briProc
		command: ["brightnessctl", "g"]
		stdout: StdioCollector {
			onStreamFinished: brightness = parseInt(this.text) / 120000 * 100
		}
		Component.onCompleted: running = true
	}

	Process {
		id: submapProc
		command: ["hyprctl", "submap"]
		stdout: SplitParser {
			onRead: data => {
				var match = data.match(/\w*/)[0]
				if (match) {
					submap = match
				}
			}
		}
		Component.onCompleted: running = true
	}

	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: {
			batProc.running = true
		}
	}

	Timer {
		interval: 200
		running: true
		repeat: true
		onTriggered: {
			volProc.running = true
			briProc.running = true
		}
	}

	Connections {
		target: Hyprland
		function onRawEvent(event) {
			submapProc.running = true
		}
	}

	RowLayout {
		anchors.fill: parent
		anchors.margins: 8
		spacing: 10

		Repeater {
			model: 9
			Text {
				property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
				property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
				text: index + 1
				color: isActive ? root.colCyan : (ws ? root.colBlue : root.colMuted)
				font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
				MouseArea {
					anchors.fill: parent
					onClicked: Hyprland.dispatch("workspace " + (index + 1))
				}
			}
		}

		Item { Layout.fillWidth: true }

		Text {
			text: submap
			color: root.colCyan
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
		}

		Rectangle { width: 1; height: 16; color: root.colMuted }

		Text {
			text: "Bri: " + brightness + "%"
			color: root.colCyan
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
		}

		Rectangle { width: 1; height: 16; color: root.colMuted }

		Text {
			text: "Vol: " + volume + "%"
			color: root.colCyan
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
		}

		Rectangle { width: 1; height: 16; color: root.colMuted }

		Text {
			text: "Bat: " + battery + "%"
			color: (battery <= 20) ? "red" : colCyan
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
		}

		Rectangle { width: 1; height: 16; color: root.colMuted }

		Text {
			id: clock
			color: root.colBlue
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
			text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
			Timer {
				interval: 1000
				running: true
				repeat: true
				onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
			}
		}
		// bluetooth | speaker
	}
}
