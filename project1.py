with open(r"c:\Users\Administrator\Desktop\servers.txt","r") as file1,open(r"c:\Users\Administrator\Desktop\valid.txt","a+") as file2,open(r"c:\Users\Administrator\Desktop\error.txt","a+") as file3:
    file1.seek(0)
    ignore_word="invalid"
    ignore_wo="unknown"

    def error(x):
        file3.write(x)
        file3.seek(0)
        file3.write(f"Total: {len(file3.readlines())}")
        return
    
    def valid():
        for line in file1:
            clean_line = line.strip()
            

            file2.seek(0)
            existing_lines = [x.strip() for x in file2.readlines()]

            if ignore_word in clean_line.lower() or ignore_wo in clean_line.lower():
                error(clean_line + "\n")

            elif clean_line in existing_lines:
                continue

            else:
                file2.write(clean_line + "\n")
                file2.flush()

        file2.seek(0)
        x=file2.readlines()
        file2.write(f"Total: {len(x)}")


    valid()

    


        
        

