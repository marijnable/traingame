extends Control

signal tile_selected
signal cancelled

const ObjectTile = preload("res://Scripts/ObjectTile.gd")
const SingleTileDisplay = preload("res://Scenes/SingleTileDisplay.gd")

# Handles selection of tiles
func _input(event: InputEvent) -> void:
    if not self.visible:
        return

    if not Mouse.is_left_released(event):
        return

    for child in self.get_children():
        if child.get("TYPE_NAME") != "SingleTileDisplay":
            continue

        var tile_display: SingleTileDisplay = child
        if not tile_display.is_canvas_position_inside(event.position):
            continue

        # Found a match!
        var tile_id = tile_display.tile_id
        var object_tile = Global.Registry.get_object_tile_from_texture_id(tile_id)
        self.get_tree().set_input_as_handled()
        emit_signal("tile_selected", object_tile)
        self.hide()
        return

    # Didn't find a match
    self.get_tree().set_input_as_handled()
    emit_signal("cancelled")
    self.hide()
