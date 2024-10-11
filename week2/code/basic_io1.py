f= open("/home/yaxin-liu/documents/CMEECoursework/week2/sandbox/test.txt","r")
# for line in f:
#     print(line)
for line in f:
    if len(line.strip())>0:
        print(line)

f.close