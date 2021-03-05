# Egregor Adversary Emulation Plan

This threat is explained further in SCYTHE's Threat Thursday blog: https://www.scythe.io/library/threatthursday-egregor

To emulate:
1. Download and import the threat in JSON format to your SCYTHE instance - https://raw.githubusercontent.com/scythe-io/community-threats/master/Egregor/Egregor_scythe_threat.json
2. Download the Virtual File System (VFS) files under Egregor/VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/egregor
4. Go to the Threat Catalog and select "Egregor"
5. Click "Create Campaign from Threat"
6. Add Execution Guardrails under "Restrict Campaign"
7. Launch the Campaign
8. Execute via Rundll32.exe