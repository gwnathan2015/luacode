-- story game about magical creatures and quests

require ("map")

function love.load()
    love.keyboard.setKeyRepeat( true )
    sprites = {}
    for i = 0, 131 do
        local filename = string.format("ASSETS/tinytown/Tiles/tile_%04d.png", i)
        sprites[i] = love.graphics.newImage(filename)
    end
    for i = 0, 131 do
        local filename = string.format("ASSETS/tinydungeon/Tiles/tile_%04d.png", i)
        sprites[i + 1000] = love.graphics.newImage(filename)
    end

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

    characters = {
        main_character, farmer
    }   

end

function love.draw()
    local col_number, row_number, row, x_c, y_c
    draw_map(game_map1, sprites)
    for num, character in pairs(characters) do
        x_c = (character.x - 1) * 16
        y_c = (character.y - 1) * 16
        c_sprite = character.sprite
        -- Draw character sprites
        love.graphics.draw(sprites[c_sprite], x_c, y_c)
    end
    for row_number, row in pairs(game_map1) do
        for col_number, tile_info in pairs(row) do
            x = (col_number - 1) * 16
            y = (row_number - 1) * 16
            if tile_info.o ~= nil then
                for depth, sprite_num in pairs(tile_info.o) do
                    love.graphics.draw(sprites[sprite_num], x, y)
                end
            end
            --print(row_number, col_number, sprite_num)
        end
    end
end

--- 85 new main character for now

function is_move_allowed(future_x, future_y)
    if future_x <= 0 then return false end
    if future_y <= 0 then return false end
    if future_y > #(game_map1) then return false end
    if future_x > #(game_map1[1]) then return false end

    for num, character in pairs(characters) do
        if future_x == character.x and future_y == character.y then 
            return false 
        end
    end

    local future_cell = game_map1[future_y][future_x]
    for index, sprite_num in pairs(future_cell.u) do
        if sprite_num == TREE_L then return false end
    end

    return true
end

function love.keypressed(key, scancode, isrepeat)
    local future_x = main_character.x
    local future_y = main_character.y

    if key == "escape" then
        love.event.quit()
    elseif key == "w" then
        future_y = main_character.y - 1
    elseif key == "a" then
        future_x = main_character.x - 1
    elseif key == "s" then
        future_y = main_character.y + 1
    elseif key == "d" then
        future_x = main_character.x + 1
    end
    if is_move_allowed(future_x, future_y) then
        main_character.x = future_x
        main_character.y = future_y
    end
end

