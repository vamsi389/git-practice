import os


with open(r"C:\Users\Administrator\Desktop\servers.txt","r")as file1,open(r"C:\Users\Administrator\Desktop\report.tmp","w+")as file2:
    for line in file1:
        file2.write(line)
        file2.write(line)
        

if os.path.isfile(r"C:\Users\Administrator\Desktop\report.txt"):
    
    os.rename(r"C:\Users\Administrator\Desktop\report.txt",r"C:\Users\Administrator\Desktop\report_backup.txt")
os.rename(r"C:\Users\Administrator\Desktop\report.tmp",r"C:\Users\Administrator\Desktop\report.txt")
   

