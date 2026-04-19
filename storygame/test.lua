game_map = {
    { 1, 1,  1,  1 }, -- row_number=1, row={1,1,1,1}
    { 1, 25, 25, 1 }, -- row_number=2, row={1,25,25,1}
    { 1, 25, 1,  1 }, -- row_number=3 row=1,25,1,1
    { 1, 1,  1,  1 },
}

test_arr =   {"A","B","C"}
-- row_number  1   2   3

for row_number, row in pairs(game_map) do
    --love.graphics.draw(sprites[1], x, y)
    for col_number, sprite_num in pairs(row) do
        print(row_number, col_number, sprite_num)        
    end
end
