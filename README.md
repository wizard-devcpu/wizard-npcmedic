<img width="1920" height="1080" alt="NPC MEDIC" src="https://github.com/user-attachments/assets/6f9ba5e3-68da-4f5a-927e-8daf029aac7f" />

# Wizard NPC Medic

### Overview
Wizard NPC Medic is an automated AI emergency service for QB-Core servers. It allows downed players to call an NPC medic to their location for a revival when medical staff are offline or unavailable.

### Features
* **Custom UI:** Sleek, modern interface styled for the WizardDev brand.
* **Smart Navigation:** NPC spawns at a distance and walks directly to the player.
* **CPR Sequence:** Immersive animations and progress bar during the revive process.
* **Economy Integration:** Automatically handles payments via cash or bank.
* **Anti-Stuck:** Restart button included in the UI to reset the NPC if navigation fails.

### How It Works
1. **Trigger:** A downed player runs the `/medic` command.
2. **Request:** The player confirms the call via the UI.
3. **Arrival:** An NPC medic spawns and moves to the player's position.
4. **Revive:** The NPC performs medical animations and restores the player's health.
5. **Cleanup:** The NPC despawns immediately after the player is revived.

### Configuration
Everything is managed via `config.lua`. You can easily adjust:
* Revival costs
* Medic ped models
* Animation settings
* Revive duration
* Spawn distances

### Support
For bugs, updates, or assistance, join the official support server:
**Discord:** [https://discord.gg/VCRs4TSy7G](https://discord.gg/VCRs4TSy7G)

### Credits
Developed by **Wizard.dev**
