extends MarginContainer

var healthProgress; var ammoProgress; var moraleProgress;

# Called when the node enters the scene tree for the first time.
func updateHealth(var newHealth):
	healthProgress.value = newHealth
	
func updateAmmo(var newAmmo):
	ammoProgress.value = newAmmo
	
func updateMorale(var newMorale):
	moraleProgress.value = newMorale;

func reset():
	healthProgress.value = 100;
	ammoProgress.value = 100
	moraleProgress.value = 100

func _ready():
	healthProgress = get_node("NinePatchRect/Health/healthProgress")
	ammoProgress = get_node("NinePatchRect/Ammo/ammoProgress")
	moraleProgress = get_node("NinePatchRect/Morale/moraleProgress")
	reset()
