from asyncore import write
import numpy as np
import torch    
import torch.nn as nn

def hex8(x):
    OUTPUT = hex(int(bin(x&0xff),2))
    return '0'*(4 - len(OUTPUT))+ OUTPUT[2:]

def hex24(x):
    OUTPUT = hex(int(bin(x&0xffffff),2))
    return '0'*(8 - len(OUTPUT))+ OUTPUT[2:]

#def f(x):
#    if (x) >= 0:
#        b = hex(x)
#        b = '0' * (8 - len(b)) + b
#    else:
#        b = 2**32 + x
#        b = hex(b)
#        b = 'f' * (8 - len(b)) + b
#    b = b.replace("0x", "")
#    b = b.replace("-", "")
#    return b

#def g(x):
#    if (x) >= 0:
#        b = hex(x)
#        b = '0' * (10 - len(b)) + b
#    else:
#        b = 2**32 + x
#        b = hex(b)
#        b = 'f' * (10 - len(b)) + b
#    b = b.replace("0x", "")
#    b = b.replace("-", "")
#    return b

a_data = []
b_data = []

for i in range(65536):
    a_data.append(np.random.randint(-128, 128))
for i in range(36864):
    b_data.append(np.random.randint(-128, 128))

with open('./iB0.coe', "w") as a:
    a.write("memory_initialization_radix = 16;\n")
    a.write("memory_initialization_vector = \n")
    s = 0
    for i in range(1024):
        for j in range(64):
            a.write(hex8(a_data[s]))
            s = s + 1
        if (i < 1023):
            a.write(",\n")
        else:
            a.write(";\n")

with open('./kB0.coe', "w") as b:
    b.write("memory_initialization_radix = 16;\n")
    b.write("memory_initialization_vector = \n")
    s = 0
    for i in range(576):
        for j in range(64):
            b.write(hex8(b_data[s]))
            s = s + 1
        if (i < 575):
            b.write(",\n")
        else:
            b.write(";\n")

a_data_prime = torch.from_numpy(np.array(a_data).reshape(1,64,32,32))
b_data_prime = torch.from_numpy(np.array(b_data).reshape(64,64,3,3))


conv_2d=nn.Conv2d(64, 1, kernel_size=3,stride=1, padding=1,bias= False)
c_data = []
for i in range(64):
    conv_2d.weight.data = b_data_prime[i].unsqueeze(0)
    with torch.no_grad():
        c_data.append(conv_2d(a_data_prime).reshape(1024).tolist())

c_data = np.array(c_data).reshape(65536)

with open('./ans.txt', "w") as ans:
    s = 0
    for i in range(1024):
        for j in range(64):
            ans.write(hex24(c_data[s]))
            s = s + 1
        if (i < 1023):
            ans.write(",\n")
        else:
            ans.write(";\n")

