return {
    openKey = 'HOME',
    toggle = true, -- If true, scoreboard will open/close on button press. If false, scoreboard stays open as long as button is held down.
    maxPlayers = GetConvarInt('sv_maxclients', 48), -- It returns 48 if it cant find the Convar Int
};
