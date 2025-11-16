extends RichTextLabel

@export var stepTime:float = 0.5

var score:int = 0
var running:bool = false


func Activate():
	show()
	running = true
	ScoreClock()
	
func Reset():
	score = 0
	UpdateScore()
	
func Deactivate():
	running = false
	
func Disappear():
	hide()
	
func ScoreClock():
	while running:
		await get_tree().create_timer(stepTime).timeout
		score = score + 1
		text = UpdateScore()

func AddScore(points:int):
	score = score + points
	text = UpdateScore()
	
func UpdateScore() -> String:
	var displayScore:String = ""
	match str(score).length():
		1: displayScore = "0000"+str(score)
		2: displayScore = "000"+str(score)
		3: displayScore = "00"+str(score)
		4: displayScore = "0"+str(score)
		5: displayScore = str(score)
		_: displayScore = "99999"
	var returnString:String = "[center]" + displayScore + "[/center]"
	return returnString
