import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Services.Mpris

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30

  Text {
    // center the bar in its parent component (the window)
    anchors.centerIn: parent

    text: "hello world"
  }
}
