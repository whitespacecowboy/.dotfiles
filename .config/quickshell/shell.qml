import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
	id: root

	property color colBg: "#111111"
	property color colFg: "#a9b1d6"
	property color colMuted: "#444b6a"
	property color colWorkpace: "#9ece6a"
	property color colSubmap: "#f7768e"
	property color colRest: "#00ff7f"
	property color colClock: "#bb9af7"
	property string fontFamily: "JetBrainsMono Nerd Font"
	property int fontSize: 14

	property int battery: 0
	property int brightness: 0
	property var volume: 0
	property var submap: ""

	property bool revealed: false

	anchors.top: true
	anchors.left: true
	anchors.right: true
	implicitHeight: revealed ? 35 : 0
	exclusiveZone: revealed ? 35 : 0

	Behavior on implicitHeight {
		NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
	}

	color: root.colBg

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		acceptedButtons: Qt.NoButton
		onEntered: revealTimer.start()
		onExited: { revealTimer.stop(); root.revealed = false }
	}

	Timer {
		id: revealTimer
		interval: 180
		onTriggered: root.revealed = true
	}

	// Auto-show briefly on workspace or submap change
	Timer {
		id: autoRevealTimer
		interval: 1500
		onTriggered: root.revealed = false
	}

	function flashReveal() {
		root.revealed = true
		autoRevealTimer.restart()
	}

	onSubmapChanged: flashReveal()
	onBrightnessChanged: flashReveal()
	onVolumeChanged: flashReveal()

	Connections {
		target: Hyprland
		function onFocusedWorkspaceChanged() { root.flashReveal() }
	}

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
				color: isActive ? root.colWorkpace : (ws ? root.colClock : root.colMuted)
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
			color: root.colSubmap
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
		}

		Rectangle { width: 1; height: 16; color: root.colMuted }

		Text {
			text: "Bri: " + brightness + "%"
			color: root.colRest
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
		}

		Rectangle { width: 1; height: 16; color: root.colMuted }

		Text {
			text: "Vol: " + volume + "%"
			color: root.colRest
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
		}

		Rectangle { width: 1; height: 16; color: root.colMuted }

		Text {
			text: "Bat: " + battery + "%"
			color: (battery <= 20) ? "red" : (battery >= 90 ) ? "white" : colRest
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
		}

		Rectangle { width: 1; height: 16; color: root.colMuted }

		Text {
			id: clock
			color: root.colClock
			font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
			text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
			Timer {
				interval: 1000
				running: true
				repeat: true
				onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
			}
		}
	}
}
