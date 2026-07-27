with open(r"C:\Users\Administrator\Desktop\config.txt","r") as file1,open(r"C:\Users\Administrator\Desktop\data.txt","r") as file2,open(r"C:\Users\Administrator\Desktop\Health_report.txt","w+") as file3:
    x=[]
    y=[]

    file3.write(f"=====================================\n")
    file3.write(f"SERVER HEALTH CHECK REPORT\n")
    file3.write(f"=====================================\n")
    file3.write(f"\n{file1.read()}\n")
            
    file3.write(f"-------------------------------------------------")
    file1.seek(0)
    
    for i in file1:
        listitems=x.append(i.strip().split("="))
    print(x)
    result_threshold=dict(x)
    cpu_threshold=int(result_threshold['cpu_threshold'])
    mem_threshold=int(result_threshold['memory_threshold'])
    output_file=result_threshold['output_file']

    for j in file2:
        data_values=y.append(j.strip().split(" ",maxsplit=3))

    print(y)

    result_usage={name: {'cpu': int(cpu), 'mem': int(mem)} for name, cpu, mem in y}
    print(result_usage)

    for a,b in result_usage.items():
        
        if result_usage[a]['cpu'] < cpu_threshold and result_usage[a]['mem'] < mem_threshold :
            file3.write(f"\n\nServer: {a}\n")
            file3.write(f"CPU: {result_usage[a]['cpu']}%\n")
            file3.write(f"MEM: {result_usage[a]['mem']}%\n")
            file3.write(f"Status is healthy\n")
            file3.write(f"-------------------------------------------------")
        else :
            file3.write(f"\n\nServer: {a}\n")
            file3.write(f"CPU: {result_usage[a]['cpu']}%\n")
            file3.write(f"MEM: {result_usage[a]['mem']}%\n")
            file3.write(f"Status is Unhealthy\n")
            file3.write(f"-------------------------------------------------")


    

    


        




    
