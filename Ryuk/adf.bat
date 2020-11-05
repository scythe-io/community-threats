adfind.exe -f "(objectcategory=person)" > %USERPROFILE%\Desktop\ryuk\ryuk_adf\ad_users.txt
adfind.exe -f "objectcategory=computer" > %USERPROFILE%\Desktop\ryuk\ryuk_adf\ad_computers.txt
adfind.exe -sc trustdmp > %USERPROFILE%\Desktop\ryuk\ryuk_adf\trustdmp.txt
adfind.exe -subnets -f (objectCategory=subnet)> %USERPROFILE%\Desktop\ryuk\ryuk_adf\subnets.txt
adfind.exe -gcb -sc trustdmp > %USERPROFILE%\Desktop\ryuk\ryuk_adf\trustdmp.txt
adfind.exe -sc domainlist > %USERPROFILE%\Desktop\ryuk\ryuk_adf\domainlist.txt
adfind.exe -sc dcmodes > %USERPROFILE%\Desktop\ryuk\ryuk_adf\dcmodes.txt
adfind.exe -sc adinfo > %USERPROFILE%\Desktop\ryuk\ryuk_adf\adinfo.txt
adfind.exe -sc dclist > %USERPROFILE%\Desktop\ryuk\ryuk_adf\dclist.txt
adfind.exe -sc computers_pwdnotreqd > %USERPROFILE%\Desktop\ryuk\ryuk_adf\computer_pwdnotereqd.txt