class_name AudioManager extends Node

var SFX_Dict:Dictionary = {}
var BGM_Dict:Dictionary = {}

var currentBGM:BackgroundMusic = null
var currentBGMPlayer:AudioStreamPlayer = null

@export var SFX:Array[SoundEffect]
@export var BGM:Array[BackgroundMusic]

func _ready() -> void:
	for soundEffect:SoundEffect in SFX:
		SFX_Dict[soundEffect.type] = soundEffect
	for backgroundMusic:BackgroundMusic in BGM:
		BGM_Dict[backgroundMusic.track] = backgroundMusic
	CreateBGM(BackgroundMusic.BGMTrack.BGM1)
		
		
func CreateAudio(type:SoundEffect.SoundEffectType) -> void:
	if Settings_Manager.muted: return
	if SFX_Dict.has(type):
		var sfx: SoundEffect = SFX_Dict[type]
		if sfx.HasOpenLimit() and !sfx.forceDisabled:
			sfx.ChangeAudioCount(1)
			var newAudio:AudioStreamPlayer = AudioStreamPlayer.new()
			add_child(newAudio)
			newAudio.stream = sfx.audioFile
			newAudio.volume_db = sfx.volume * Settings_Manager.volumeControl
			newAudio.pitch_scale = sfx.pitchScale
			newAudio.pitch_scale += randf_range(-sfx.pitchRandomness, sfx.pitchRandomness)
			newAudio.finished.connect(sfx.OnAudioFinished)
			newAudio.finished.connect(newAudio.queue_free)
			newAudio.play()
			if sfx.forceTimeDelay != 0.0:
				sfx.forceDisabled = true
				await get_tree().create_timer(sfx.forceTimeDelay).timeout
				sfx.forceDisabled = false
		else:
			pass
			#push_error("Audio Manager failed to find setting for type ", type)

func CreateBGM(track:BackgroundMusic.BGMTrack) -> void:
	print(BGM_Dict)
	if BGM_Dict.has(track):
		print("has " + str(track))
		var bgm: BackgroundMusic = BGM_Dict[track]
		currentBGM = bgm
		if currentBGMPlayer == null:
			var newBGM = AudioStreamPlayer.new()
			add_child(newBGM)
			currentBGMPlayer = newBGM
			newBGM.finished.connect(OnBGMFinished)
			PlayBGM(bgm, newBGM)
		else: PlayBGM(currentBGM, currentBGMPlayer)

func PlayBGM(bgm:BackgroundMusic, newBGM:AudioStreamPlayer) -> void:
			if bgm.fadeInTime > 0: newBGM.volume_db = -20
			else: newBGM.volume_db = bgm.volume
			
			if bgm.entryTime > 0: await get_tree().create_timer(bgm.entryTime).timeout
			newBGM.stream = bgm.audioFile
			newBGM.play()
			
			if bgm.fadeInTime > 0:
				var tween = get_tree().create_tween()
				tween.tween_property(newBGM, "volume_db", bgm.volume, bgm.fadeInTime)
			if bgm.fadeOutTime > 0:
				await get_tree().create_timer(bgm.audioFile.get_length() - bgm.fadeOutTime).timeout
				var tween = get_tree().create_tween()
				tween.tween_property(newBGM, "volume_db", 0.0, bgm.fadeOutTime)


		
				
func OnBGMFinished() -> void:
	print("finished")
	if currentBGM.exitTime > 0: await get_tree().create_timer(currentBGM.exitTime).timeout
	var nextTrack = randi_range(BackgroundMusic.BGMTrack.BGM1, BackgroundMusic.BGMTrack.OUR_NIGHT)
	print(str(nextTrack) + "vs. " + str(currentBGM.track))
	while nextTrack == currentBGM.track: nextTrack = randi_range(BackgroundMusic.BGMTrack.BGM1, BackgroundMusic.BGMTrack.OUR_NIGHT)
	currentBGM = null
	CreateBGM(nextTrack)
