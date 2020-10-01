# SLOTHFULMEDIA Adversary Emulation Plan

Based on Cyber Threat Intelligence from US-Cert: https://us-cert.cisa.gov/ncas/analysis-reports/ar20-275a

To emulate:
1. Import the threat into SCYTHE
2. Create a campaign from threat
3. Use HTTP or HTTPS over default TCP port (80 or 443 respectively)
4. Set header to "User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75"
5. Set Timestamp to 2019-04-29T10:18:34
6. Download the 32-bit EXE and rename to mediaplayer.exe