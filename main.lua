local replicatedstorage = game:GetService('ReplicatedStorage')
local status = replicatedstorage:WaitForChild('InfoValue')
local mapstorage = game.Workspace:WaitForChild('MapStorage')
while true do

while game.Players.NumPlayers < 2 do -- How much players that the server has to have in order to start
	status.Value = 'There needs to be two players to start'
	repeat wait(2) until game.Player.NumPlayers <= 2
end

for i = 50,0,-1 do -- How much time for the intermission
	status.Value = 'Intermission '..i
	wait(1)
end	
_G.gameplayers = {}
for i, v in pairs(game.Players:GetPlayers()) do

if v then
	table.insert(_G.gameplayers, v.name)
end

end

local mapsinserverstorage = game:GetService('ServerStorage'): GetChildren()
local chosenmap = mapsinserverstorage[math.random(1, #mapsinserverstorage)]
chosenmap:Clone().Parent = mapstorage
status.Value = 'Get Ready for the Next Round!'
wait(3)
local spawns = chosenmap:WaitForChild('Spawns'):GetChildren()
for _, player in pairs(game.Players:GetPlayers()) do
	if player and #spawns > 0 then
		local torso = player.Character:WaitForChild('HumanoidRootPart')
		local allspawns = math.random(1, #spawns)
		local randomspawn = spawns[allspawns]
		if randomspawn and torso then
			table.remove(spawns, allspawns)
			torso.CFrame = CFrame.new(randomspawn.Position + Vector3.new(0,2,0))
			
			local sword = game.ReplicatedStorage.Sword
			local newsword = sword:Clone()
			newsword.Parent = player.Backpack
		end
	end
end

for i = 120,0,-1 do
	if i == 0 then
		status.Value = 'The Round is Over!'
		break
	end
	wait(1)
	if #_G.gameplayers == 1 then
		for i, v in pairs(_G.gameplayers) do
			if v ~= nil then
				status.Value = v..' is the winner!'
				wait(2)
				game.Players[v].leaderstats.Points.Value = game.Players[v].leaderstats.Points.Value + 10
				status.Value = v..' has been given 10 points!'
				break
			end
			
		end
		break
	else
		status.Value = i.. ' seconds remaining'
	end	
end		
	
game.Workspace.MapStorage:ClearAllChildren()	
wait(10)
end 