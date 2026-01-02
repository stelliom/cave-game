extends TileMapLayer


func _ready():
    GlobalSignals.bomb_exploded.connect(_on_bomb_exploded)

func _on_bomb_exploded(global_coords):
    var local_coords = to_local(global_coords)
    var cell = local_to_map(local_coords)

    erase_cell(cell)
    for neighbor in get_neighbors(cell):
        erase_cell(neighbor)

func get_neighbors(cell):
    var cells = get_surrounding_cells(cell)

    cells.append(get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER))
    cells.append(get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER))
    cells.append(get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER))
    cells.append(get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER))

    return cells
    
