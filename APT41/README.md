# APT41 Adversary Emulation Plan

Based on the Adversary Emulation Plan published here: https://security-tzu.com/2020/09/23/emulation-plan-for-apt41/

To emulate:
1. Import the threat into SCYTHE
2. Create a campaign from threat
3. Restrict campaign to the device or domain where it will execute. This is to emulate APT41 use of Execution Gaurdrails: Environmental Keying (T1480.001)
4. Select the Communication module. Use DNS, HTTP, or HTTPS over default TCP port 53, 80 or 443 respectively - HTTP and HTTPS will be much quicker. However, APT41 uses DNS as well. We recommend using DNS as long-haul C2 only.
5. Start Campaign