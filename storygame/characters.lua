

main_character = {
        x = 2,
        y = 1,
        sprite = 1085
    }

    farmer = {
        x = 5,
        y = 3,
        sprite = 1085
    }

all_characters = {
    main_character, farmer
}   

function draw_characters(characters, sprites)
    local x_c, y_c, c_sprite
    for num, character in pairs(characters) do
        x_c = (character.x - 1) * 16
        y_c = (character.y - 1) * 16
        c_sprite = character.sprite
        -- Draw character sprites
        love.graphics.draw(sprites[c_sprite], x_c, y_c)
    end
end

function is_move_allowed(future_x, future_y, game_map)
    if future_x <= 0 then return false end
    if future_y <= 0 then return false end
    if future_y > #(game_map) then return false end
    if future_x > #(game_map[1]) then return false end

    for num, character in pairs(all_characters) do
        if future_x == character.x and future_y == character.y then 
            return false 
        end
    end

    local future_cell = game_map[future_y][future_x]
    for index, sprite_num in pairs(future_cell.u) do
        if sprite_num == TREE_L then return false end
    end

    return true
end
