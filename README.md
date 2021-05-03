# Adversary Emulation Plan Library
This repository is for sharing adversary emulation plans in JSON format.
Currently we support SCYTHE threats and MITRE ATT&CK Navigator both of which use JSON.

## How-to use the library
1. Select the adversary folder you are interested in.
2. Review the README if available or the #ThreatThursday blog post: https://www.scythe.io/threatthursday
3. Download the raw JSON file for the platform you would like to use.

## Import into SCYTHE
1. Login to the SCYTHE instance where you want to migrate the threat to
2. Click Threat Manager - Migrate Threats
3. Under "Import Threat" click “Choose File” and select the JSON file 
4. Click Import

## Import into MITRE ATT&CK Navigator
1. Launch MITRE ATT&CK Navigator: https://mitre-attack.github.io/attack-navigator/
2. Click the + next to the layer on the top left.
3. Select Open Existing Layer
4. Upload from local - upload the JSON downloaded from the library, syntax is $ADVERSARYNAME_ATT&CK_Navigator.json
5. You can also load it straight from GitHub by using raw JSON URL link and replacing the #layer_url: https://mitre-attack.github.io/attack-navigator/#layerURL=https://raw.githubusercontent.com/scythe-io/community-threats/master/APT41/APT41_ATT%26CK_Navigator.json

## Community Effort
SCYTHE believes in giving back to the community and encourages everyone to do the same. Please submit pull requests with new threats in their respective folder and we will review and approve.
