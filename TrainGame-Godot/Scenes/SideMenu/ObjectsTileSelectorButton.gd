extends Control

signal tile_selected  # Supplies one argument of type ObjectsTile

# Handles selection of tiles
func _on_ObjectsTileSelectorButton_pressed() -> void:  
    # Open popup
    var popup = $ObjectsTileSelectorPopup
    popup.popup()

    self.get_tree().set_input_as_handled()
    


func _on_ObjectsTileSelectorPopup_tile_selected(tile: ObjectTile) -> void:
    # Update UI
    self.texture_normal = tile.create_texture()

    # Forward
    emit_signal("tile_selected", tile)
