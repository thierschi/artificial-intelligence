-- Thiersch, Lukas
-- 1607110, bt708626

-- Exercise 5b
-- tree data structure
local function tree (xVal, yVal, left, right)
    return {
        x = xVal,
        y = yVal,
        leftChild = left,
        rightChild = right
    }
end

-- the tree itself
tree = tree(
    4, 3,
    tree(
        2, 3,
        tree(
            2, 5, 
            tree(3, 5, nil, nil),
            tree(1, 5, nil, nil)
        ),
        tree(
            2, 1,
            tree(1, 1, nil, nil),
            tree(3, 1, nil, nil)
        )
    ),
    tree(
        6, 3,
        tree(
            6, 5, 
            tree(5, 5, nil, nil),
            tree(7, 5, nil, nil)
        ),
        tree(
            6, 1,
            tree(5, 1, nil, nil),
            tree(7, 1, nil, nil)
        )
    )
)

-- Exercise 2b

-- Helper that determines the direction from start to dest based on their
-- coordinates
local function getDirectionToNode(start, dest)
    x = start.x - dest.x
    y = start.y - dest.y

    if (x == 0) then dir = y > 0 and 'N' or 'S' end
    if (y == 0) then dir = x > 0 and 'W' or 'E' end

    return dir
end

local function isleaf(node)
    return node.leftChild == nil and node.rightChild == nil
end

-- Recursive function that finds the path from the root note to a leaf
-- with coords x, y
-- Caution: Resulting list is inverted
-- Assumption: x, y are always from a valid leaf
local function getPath(x, y, node, list)
    -- base case
    if (node == nil) then return nil end
    
    if (isleaf(node) and not (node.x == x and node.y == y)) then
        return false -- leaf not at x,y
    end

    if (isleaf(node) and node.x == x and node.y == y) then
        return true --  leaf at x,y
    end

    if (getPath(x, y, node.leftChild, list)) then -- left child is on path or leaf at x,y
        table.insert(list, getDirectionToNode(node, node.leftChild))
        return true
    end

    if (getPath(x, y, node.rightChild, list)) then -- right child is on path or leaf at x,y
        table.insert(list, getDirectionToNode(node, node.rightChild))
        return true;
    end

    -- wrong path
    return false
end

-- Gets the path to passenger and home
-- Assumption: x, y are always from a valid leaf
local function getFullPath (x, y, node, list)
    pathToleaf = {}
    getPath(x, y, tree, pathToleaf)

    for i = 1, #pathToleaf do  -- invert path to passnger
        list[i] = pathToleaf[#pathToleaf - (i - 1)]
    end

    for i = 2, #pathToleaf do -- get path home
        dir = pathToleaf[i]
        
        if (dir == 'N') then table.insert(list, 'S')
        elseif (dir == 'E') then table.insert(list, 'W')
        elseif (dir == 'S') then table.insert(list, 'N')
        elseif (dir == 'W') then table.insert(list, 'E')
        end
    end

    -- The destination 4,2 is a leaf but the exercise requires a binary tree
    -- hence 4,2 could not be added to tree and this junction must be handled
    -- by hand.
    table.insert(list, 'N')
end

path = {}
count = 1;

function ai.init(map, money)
    buyTrain(4,2)
    money = money - 25
end

function ai.newPassenger(name, x, y)
    path = {}
    getFullPath(x, y, tree, path)
    count = 1
end

function ai.foundPassengers(train, passengers)
	return passengers[1]
end

function ai.chooseDirection(train, directions)
    count = count + 1
    return path[count - 1] -- this saves on line
end

function ai.foundDestination(train)
	dropPassenger(train)
end