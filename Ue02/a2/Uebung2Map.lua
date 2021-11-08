local ch = {}

ch.name = "Uebung2Map"
ch.version = "5"

ch.maxTrains = 1
ch.startMoney = 25

ch.region = "Urban"

-- create a new, empty map:
ch.map = challenges.createEmptyMap(14, 1)

-- fill some of the tiles with Rails and Houses:
ch.map[1][1] = "C"
ch.map[2][1] = "C"
ch.map[3][1] = "C"
ch.map[4][1] = "C"
ch.map[5][1] = "C"
ch.map[6][1] = "C"
ch.map[7][1] = "C"
ch.map[8][1] = "C"
ch.map[9][1] = "C"
ch.map[10][1] = "C"
ch.map[11][1] = "C"
ch.map[12][1] = "C"
ch.map[13][1] = "C"
ch.map[14][1] = "C"

local startTime = 0
local passengersCreated = false
local maxTime = 600
local passengersRemaining = 5
local passengersHome = 0
local moneyEarned = 0
local startupMessage =
    "The City of Logic welcomes you!\nYou have to decide whom to take in at a stop.\n'All passengers are equal, but some passengers are more solvent than others!'"

function ch.start() challenges.setMessage(startupMessage) end

function ch.update(time)
    if time > 5 and not passengersCreated then
        passengersCreated = true
        passenger.new(5, 1, 10, 1, "I'm broke!", "off")
        passenger.new(5, 1, 10, 1, "Show me the money!", "on")
        passenger.new(5, 1, 10, 1, "I'm broke!", "off")
        passenger.new(5, 1, 1, 1, "Show me the money!", "on")
        passenger.new(9, 1, 4, 1, "I'm broke!", "off")
        passenger.new(9, 1, 14, 1, "Show me the money!", "on")
        passenger.new(9, 1, 4, 1, "I'm broke!", "off")
        challenges.removeMessage()
    end
    if time > maxTime then
        return "lost", "You made " .. moneyEarned .. " bucks!"
    end
    if moneyEarned >= 500 then
        return "won", "Made " .. moneyEarned .. " bucks!"
    end
    challenges.setStatus("Map by AI5\n" .. moneyEarned .. " bucks earned\n" ..
                             math.floor(maxTime - time) .. " seconds left")
end

function ch.passengerDroppedOff(tr, p)
    if tr.tileX == p.destX and tr.tileY == p.destY then
        passengersRemaining = passengersRemaining - 1
        passengersHome = passengersHome + 1
        if p.vipTime and p.vipTime > 0 then
            moneyEarned = moneyEarned + 25
        end
        passenger.new((12 - p.destX) % 14, 1, (p.destX) % 14 + 2 + 1, 1,
                      "Show me the money!", "on")
    end
end

return ch
