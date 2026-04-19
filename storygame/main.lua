-- story game about magical creatures and quests

require ("map")
require ("characters")

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
end

function love.draw()
    local col_number, row_number, row, x_c, y_c
    draw_map(game_map1, sprites)
    draw_characters(all_characters, sprites)
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
    if is_move_allowed(future_x, future_y, game_map1) then
        main_character.x = future_x
        main_character.y = future_y
    end
end

