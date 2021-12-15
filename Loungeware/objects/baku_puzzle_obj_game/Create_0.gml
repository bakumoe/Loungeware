
// Coordinate conversion funcs
xy_to_i = function(_x, _y, _w) {
	return _y * _w + _x;
}

i_to_xy = function(_i, _w) {
	return [_i mod _w, _i div _w];
}

i_to_x = function(_i, _w) {
	return _i mod _w;
}

i_to_y = function(_i, _w) {
	return _i div _w;
}


// Puzzle sprite constructor
Puzzle = function(_sprite_index, _w, _h, _empty_subimg) constructor {
	sprite_index = _sprite_index;
	w = _w;
	h = _h;
	empty_subimg = _empty_subimg;
}

// Puzzle sprites
puzzles = [];
array_push(puzzles, new Puzzle(baku_puzzle_spr_puzzletest, 3, 3, 8));

// Set current puzzle
current_puzzle = 0;

// Create """grid"""
grid_w = puzzles[current_puzzle].w;
grid_h = puzzles[current_puzzle].h;
grid_list = ds_list_create();
for (var i = 0; i < grid_w * grid_h; ++i) {
	ds_list_add(grid_list, i);
}

// Shuffle (DEBUG!!! TESTING!!! DONT ENABLE THIS IN SHIPPING!!! IT CAN BREAK PARITY!!!)
// ds_list_shuffle(grid_list);

// Puzzle logic
empty_x = 0;
empty_y = 0;

// Find empty xy
for (var i = 0; i < grid_w * grid_h; ++i) {
	var _x = i_to_x(i, grid_w);
	var _y = i_to_y(i, grid_w);
	var _id = grid_list[| i];
	
	if _id == puzzles[current_puzzle].empty_subimg {
		empty_x = _x;
		empty_y = _y;
	}
}
