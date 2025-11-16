class_name BackgroundMusic extends Resource

enum BGMTrack {
	BGM1,
	BEAUTIFUL_ISLAND,
	HYPNOTIZED,
	OUR_NIGHT
}

#buffers of empty audio before and after the clip
@export var entryTime:float = 0.0
@export var exitTime:float = 0.0

#how much of the beginning / end of the clip you want to have fade in / out effects
@export var fadeInTime:float = 0.0
@export var fadeOutTime:float

@export var track:BGMTrack
@export var audioFile:AudioStreamMP3
@export_range(-40,20) var volume:float = 0
