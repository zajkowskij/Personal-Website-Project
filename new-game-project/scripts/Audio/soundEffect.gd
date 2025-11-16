class_name SoundEffect extends Resource

enum SoundEffectType 
{NULL,
MOUSE_CLICK_ACCEPT,
DRAG,
DRAG_RELEASE,
MOUSE_CLICK_SINGLE,
SCROLLBAR,
DRAWER_OPEN,
COWBELL,
CORNER_HIT,
CLAP,
PIANO
}

# how many times same audio file can be played simultaneously
@export_range(0,10) var audioStackLimit: int = 5 

#instances of the current audio file playing simultaneously
var audioCount:int = 0 

#the amount of time in seconds that must elapse before this audio can be played again
@export var forceTimeDelay:float = 0.0

var forceDisabled:bool = false

@export var type:SoundEffectType
@export var audioFile:AudioStreamMP3
@export_range(-40,20) var volume:float = 0
@export_range(0.0, 4.0, .01) var pitchScale:float = 1.0
@export_range(0.0, 1.0, .01) var pitchRandomness:float = 0.0

func ChangeAudioCount(amount:int) -> void:
	audioCount = max(0, audioCount + amount)
	
func HasOpenLimit() -> bool:
	return audioCount < audioStackLimit
	
func OnAudioFinished() -> void:
	ChangeAudioCount(-1)
