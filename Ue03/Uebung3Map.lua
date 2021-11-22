local ch = {}

ch.name = "Uebung3Map"
ch.version = "5"

ch.maxTrains = 1
ch.startMoney = 25

ch.region = "Urban"

-- create a new, empty map:
ch.map = challenges.createEmptyMap(7, 5)

-- fill some of the tiles with Rails and Houses:
ch.map[4][2] = "C"
ch.map[4][3] = "C"
ch.map[5][3] = "C"
ch.map[6][3] = "C"
ch.map[6][2] = "C"
ch.map[6][1] = "C"
ch.map[5][1] = "C"
ch.map[7][1] = "C"
ch.map[6][4] = "C"
ch.map[6][5] = "C"
ch.map[5][5] = "C"
ch.map[7][5] = "C"
ch.map[3][3] = "C"
ch.map[2][3] = "C"
ch.map[2][2] = "C"
ch.map[2][1] = "C"
ch.map[2][4] = "C"
ch.map[2][5] = "C"
ch.map[1][5] = "C"
ch.map[3][5] = "C"
ch.map[1][1] = "C"
ch.map[2][1] = "C"
ch.map[3][1] = "C"

local startTime = 0
local passengersCreated = false
local maxTime = 600
local passengersRemaining = 7
local passengersHome = 0
local vipHome = 0
local moneyEarned = 0

local t = {
{x=1, y=1, destX=4, destY=2},
{x=5, y=5, destX=4, destY=2},
{x=3, y=1, destX=4, destY=2},
{x=5, y=5, destX=4, destY=2},
{x=1, y=5, destX=4, destY=2},
{x=3, y=1, destX=4, destY=2},
{x=5, y=1, destX=4, destY=2}}

function ch.start()
end

function ch.update(time)
	if time > 1 and not passengersCreated then
		passengersCreated = true
		position = t[1]
		passenger.new( position.x, position.y, position.destX, position.destY, "I'm here!", "off")
	end
	if time > maxTime then
		return "lost", "You brought only " .. passengersHome .. " home!"
	end
	if passengersHome >= 7 then
		return "won", "You brought all " .. passengersHome .. " home!"
	end
	challenges.setStatus("You have\n"
							.. passengersRemaining .. " passengers left to bring home,\n"
							.. passengersHome .. " passengers at home and\n"
							.. math.floor(maxTime-time) .. " seconds left.")
end

function ch.passengerDroppedOff(tr, p)
	if tr.tileX == p.destX and tr.tileY == p.destY then	
		passengersRemaining = passengersRemaining - 1
		passengersHome = passengersHome + 1

		if(passengersRemaining>0) then
			position = t[passengersHome+1]
			passenger.new( position.x, position.y, position.destX, position.destY, "I'm here!", "off")
		end
	end
end

return ch
