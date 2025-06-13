import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Services.Mpris

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    Text {
		anchors.verticalCenter: parent.verticalCenter
		text: Mpris.nowPlaying ? `Now Playing: ${Mpris.nowPlaying.title} - ${Mpris.nowPlaying.artist}` : "No music playing"
		Connections {
			target: Mpris
			onNowPlayingChanged: text = Mpris.nowPlaying ? `Now Playing: ${Mpris.nowPlaying.title} - ${Mpris.nowPlaying.artist}` : "No music playing"
		}
    }

	Button {
		text: "aaa"
		onClicked: ()=>{
			console.log(JSON.stringify(Mpris.players.values.map(a=>`${a.trackArtist} - ${a.trackTitle}`),undefined,"\t"))
			console.log(MprisPlaybackState)
		}
	}
}
