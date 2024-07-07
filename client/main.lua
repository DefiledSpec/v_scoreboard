local config = require 'config.client';
local isScoreboardOpen, onDutyAdmins;

local function openScoreboard()
    local players, cops, admins = lib.callback.await('qbx_scoreboard:server:getScoreboardData');
    onDutyAdmins = admins;

    SendNUIMessage({
        action = 'open',
        players = players,
        maxPlayers = config.maxPlayers,
        requiredCops = GlobalState.illegalActions,
        currentCops = cops
    });

    isScoreboardOpen = true;
end

local function closeScoreboard()
    SendNUIMessage({
        action = 'close',
    });

    isScoreboardOpen = false;
end

-- Command
if config.toggle then
    lib.addKeybind({
        name = 'scoreboard',
        description = 'Open Scoreboard',
        defaultKey = config.openKey,
        onPressed = function()
            if isScoreboardOpen then
                closeScoreboard()
            else
                openScoreboard()
            end
        end,
    });
else
    lib.addKeybind({
        name = 'scoreboard',
        description = 'Open Scoreboard',
        defaultKey = config.openKey,
        onPressed = openScoreboard,
        onReleased = closeScoreboard
    });
end

-- Threads
CreateThread(function()
    Wait(1000);
    local actions = {};
    for k, v in pairs(GlobalState.illegalActions) do
        actions[k] = v.label;
    end
    SendNUIMessage({
        action = 'setup',
        items = actions
    });
end);
