

-- Any kind of character in the story game, e.g. the main player
Character = {
        x = 0,
        y = 0,
        all_characters = {}
    }

Character.__index = Character

-- Create a new Character.
--
-- put name and sprite into the new character.
-- Add the new character to the table list of all_characters.
function Character:new(name, sprite)
    local new_object = {sprite = sprite, name = name}
    setmetatable(new_object, self)
    new_object.__index = Character
    table.insert(Character.all_characters, new_object)
    return new_object
end


-- Moves the character around, unconditionally. edits character self.x and self.y
function Character:move(dx, dy)
    if self.x == 0 and dx < 0 then
        return false
    end
    self.x = self.x + dx
    self.y = self.y + dy
    return true
end

-- Prints the character's information in the console.
function Character:print()
    print("---- ", self.name)
    print("x=", self.x)
    print("y=", self.y)
    print("s=", self.sprite)
end

-- Makes the character appear on a Love2d canvas.
function Character:draw(sprites)
        local x_c = (self.x - 1) * 16
        local y_c = (self.y - 1) * 16
        local c_sprite = self.sprite
        -- Draw character sprites
        love.graphics.draw(sprites[c_sprite], x_c, y_c)
end

main_character = Character:new("player", 1085)
main_character:move(2,1)

wizard = Character:new("wizard", 1084)
wizard:move(10,2)


function draw_characters(sprites)
    for num, character in pairs(Character.all_characters) do
        character:draw(sprites)
    end
end

function is_move_allowed(future_x, future_y, game_map)
    if future_x <= 0 then return false end
    if future_y <= 0 then return false end
    if future_y > #(game_map) then return false end
    if future_x > #(game_map[1]) then return false end

    for num, character in pairs(Character.all_characters) do
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
