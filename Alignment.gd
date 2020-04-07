extends VBoxContainer

var messages = [
	"Hello, my\nson.",
	"You are\nhere for\na reason",
	"I have a\nmission for you.",
	"You must find\n",
	"...",
	"Your son",
]

var cur_message = 0
var currently_writing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	next_message()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			next_message()

func next_message():
	if cur_message < messages.size():
		$Chat.set_text(messages[cur_message])
		cur_message += 1
