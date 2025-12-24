extends TileMapLayer


func on_bomb_exploded(coords):
    var local_pos = to_local(coords)
    var cell = local_to_map(local_pos)
    erase_cell(cell)
    for neighbor in get_surrounding_cells(cell) + get_diagonal_cells(cell):
        erase_cell(neighbor)

func get_diagonal_cells(cell):
    var cells = []
    cells.append(get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER))
    cells.append(get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER))
    cells.append(get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER))
    cells.append(get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER))
    return cells
