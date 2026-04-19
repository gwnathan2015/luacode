


-- Character in the story game, e.g. the main player
Character = { x = 0, y = 0, inventory = {} }

function Character:move(dx, dy)
    if Character.x == 0 and dx < 0 then
        return false
    end
    Character.x = Character.x + dx
    Character.y = Character.y + dy
    return true
end

function Character:pick_up(item)
    Character.inventory:insert(item)
end

print(Character.x, Character.y)
Character:move(1, 0)
print(Character.x, Character.y)
