extends CanvasLayer


# COLORS.
const GREEN: Color = Color("6BBFA3")
const RED: Color = Color(0.9, 0, 0, 1)
# CONTAINERS.
@onready var LASER_CONTAINER: VBoxContainer = $LaserCounter/VBoxContainer
@onready var GRENADE_CONTAINER: VBoxContainer = $GrenadeCounter/VBoxContainer
@onready var HEALTH_BAR: TextureProgressBar = $HealthContainer/HealthBar


func _ready():
	Global.connect("update_laser", update_display_laser)
	Global.connect("update_grenade", update_display_grenade)
	Global.connect("update_health", update_display_health)
	update_display_laser()
	update_display_grenade()
	update_display_health()


# UPDATE DISPLAY.
func update_display_laser():
	%LaserQuantity.text = str(Global.laser_quantity)
	update_display_color(Global.laser_quantity, LASER_CONTAINER)


func update_display_grenade():
	%GrenadeQuantity.text = str(Global.grenade_quantity)
	update_display_color(Global.grenade_quantity, GRENADE_CONTAINER)


func update_display_health():
	HEALTH_BAR.value = Global.health_quantity
	update_display_color(Global.health_quantity, HEALTH_BAR, 50)


func update_display_color(quantity: int, container: Variant, limit: int = 0) -> void:
	container.modulate = GREEN if quantity > limit else RED
