
// Debug draw stuff
draw_set_colour(c_white);
var _x = 16, _y = 16, _newline = 16;

// Draw list of ssubimg ids in order
var _list_string = "";
for (var i = 0; i < grid_w * grid_h; ++i) {
	_list_string += string(grid_list[| i]);
}
draw_text(16, 16, "order: " + _list_string);
_y += _newline;

// Is it solved?
var _solved = _list_string == "012345678";
draw_text(_x, _y, "solved: " + string(_solved));
_y += _newline;

// Empty cell position
draw_text(_x, _y, "empty cell: " + string(empty_x) + "," + string(empty_y));
_y += _newline;




// Draw pieces
var _base_x = 16;
var _base_y = 192;
var _cell_w = 32;
var _cell_h = 32;
var _cell_margin = 4;

for (var i = 0; i < grid_w * grid_h; ++i) {
	// Calc x and y in """grid"""
	var _x = i_to_x(i, grid_w);
	var _y = i_to_y(i, grid_w);
	var _id = grid_list[| i];
	
	var _draw_x = _base_x + (_cell_w * _x) + (_cell_margin * _x);
	var _draw_y = _base_y + (_cell_h * _y) + (_cell_margin * _y);
	
	draw_sprite(puzzles[current_puzzle].sprite_index, _id, _draw_x, _draw_y);
	
	if _id != puzzles[current_puzzle].empty_subimg {
		draw_rectangle(_draw_x, _draw_y, _draw_x + _cell_w - 1, _draw_y + _cell_h - 1, true);
	}
}