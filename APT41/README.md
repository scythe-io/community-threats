# APT41 Adversary Emulation Plan

Based on the Adversary Emulation Plan published here: https://security-tzu.com/2020/09/23/emulation-plan-for-apt41/
#ThreatThursday blog post: https://www.scythe.io/library/threatthursday-apt41

To emulate:

1. Download and import the threat in JSON format to your SCYTHE instanc:https://github.com/scythe-io/community-threats/blob/master/APT41/APT41_scythe_threat.json
2. Download the Virtual File System (VFS) files under APT41/VFS: https://github.com/ElaineNeuk/community-threats/tree/master/APT41/VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/APT41
4. Click "Create Campaign from Threat"
5. Name the Campaign
6. Parameters: Replace unicorn.scythedemo.com with your SCYTHE instance IP address or FQDN.
7. Restrict campaign to the device or domain where it will execute. This is to emulate APT41 use of Execution Gaurdrails: Environmental Keying (T1480.001)
8. Select the Communication module. Use DNS, HTTP, or HTTPS over default TCP port 53, 80 or 443 respectively - HTTP and HTTPS will be much quicker. However, APT41 uses DNS as well. We recommend using DNS as long-haul C2 only.
9. Start Campaign
