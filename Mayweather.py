interFile = open("output.txt","w")

interFile.write("DEPTH = 1024;\n\nWIDTH = 24;\n\nADDRESS_RADIX = UNS;\n\nDATA_RADIX = BIN;\n\n")
interFile.write("CONTENT\n\nBEGIN\n")
interFile.close()

labels = {}
regValue = {}
Rtype = ['add','sub','and','or','xor','sll','cmp','jr']
Dtype = ['lw','sw','addi','subi','si']
Btype = ['b','bal']
Jtype = ['j','jal','li']
aluOp = {'add': '100','sub': '011','and': '111','or': '110','xor': '101'
         ,'sll': '000','cmp': '000','jr': '000'}
register = {'r0':'0000','r1': '0001','r2': '0010','r3': '0011','r4': '0100'
             ,'r5': '0101','r6': '0110','r7': '0111','r8': '1000','r9': '1001'
             ,'r10': '1010','r11': '1011','r12': '1100','r13': '1101','r14': '1110'
             ,'r15': '1111','sp':'1110'}
opCode = {'add': '0000','sub': '0000','and': '0000','or': '0000','xor': '0000'
          ,'sll': '0011','cmp': '0010','jr': '0001','lw': '0100','sw': '0101'
          ,'addi': '0110','si': '0111','subi': '0110','b': '1000','bal': '1001'
          ,'j': '1100','jal': '1101','li': '1110'}
cond = {'none':'0000','nv': '0001','eq': '0010','ne': '0011','vs': '0100'
        ,'vc': '0101','mi': '0110','pl': '0111','cs': '1000','cc': '1001'
        ,'hi': '1010','ls': '1011','gt': '1100','lt': '1101','ge': '1110'
        ,'le': '1111'}
memloc = 1

def parseCommand(line,interFile):
  global register
  global opCode, memloc, aluOp, cond
  global Rtype, Dtype, Btype, Jtype
  s = str(0)

  if('ret' in line):
    pass
  elif('nop' in line):
    interFile.write(str(memloc) + ": " + '0' * 24 + ';\n')
  else:
    comm,param = line.split(" ")
    if(comm in Dtype):
      param = param.split(',')
      if(len(param) < 3):
        imm = '0' * 7
        imm += bin(int(param[1][1:-3]))[2:]
        imm = imm[-7:]
        if(comm[-2:] in cond):
          interFile.write(str(memloc) + ": " + opCode[comm[:-2]] + cond[comm[-2:]]
                + s + imm + register[param[1][-2:]] + register[param[0]] + ';\n')
        else:
          interFile.write(str(memloc) + ": " + opCode[comm] + cond['none']
                + s + imm + register[param[1][-2:]] + register[param[0]] + ';\n')
      else:
        imm = '0' * 7
        imm += bin(int(param[2]))[2:]
        imm = imm[-7:]
        if(comm[-2:] in cond):
          interFile.write(str(memloc) + ": " + opCode[comm[:-2]] + cond[comm[-2:]]
                + s + imm + register[param[1]] + register[param[0]] + ';\n')
        else:
          interFile.write(str(memloc) + ": " + opCode[comm] + cond['none']
                + s + imm + register[param[1]] + register[param[0]] + ';\n')
    elif(comm in Btype or comm[:1] in Btype):
      if(len(comm) > 1):
        if(comm[-2:] in cond):
          interFile.write(str(memloc) + ": " + opCode[comm[:-2]] + cond[comm[-2:]]
                 + '?' + param + ';\n')
        else:
          interFile.write(str(memloc) + ": " + opCode[comm] + cond['none']
                 + '?' + param + ';\n')
      else:
        interFile.write(str(memloc) + ": " + opCode[comm] + cond['none']
               + '?' + param + ';\n')
    elif(comm in Jtype):
      if(comm == 'li'):
        param = param.split(",")
        con = '0' * 16
        con += bin(int(param[1],16))[2:]
        con = con[-16:]
        interFile.write(str(memloc) + ": " + opCode[comm] + register[param[0]] + con + ';\n')
        regValue[param[0]] = con #for loads and stores later
      else:
        con = '0' * 20
        con += bin(int(param,16))[2:]
        con = con[-20:]
        interFile.write(str(memloc) + ": " + opCode[comm] + con + ';\n')
    elif(comm in Rtype):
      if(comm == 'jr'):
        interFile.write(str(memloc) + ": " + opCode[comm] + cond['none']
              + s + aluOp[comm] + "0000" + register[param] + '0000;\n')
      else:
        param = param.split(",")
        if(comm == 'cmp'):
          s = str(1)
          interFile.write(str(memloc) + ": " + opCode[comm] + cond['none']
                + s + aluOp[comm] + "0000" + register[param[0]] + register[param[1]]
                + ';\n')
        elif(comm[-2:] in cond):
          interFile.write(str(memloc) + ": " + opCode[comm[:-2]] + cond[comm[-2:]]
                + s + aluOp[comm] + register[param[1]] + register[param[2]]
                + register[param[0]] + ';\n')
        else:
          interFile.write(str(memloc) + ": " + opCode[comm] + cond['none']
                + s + aluOp[comm] +  register[param[1]] + register[param[2]]
                + register[param[0]] + ';\n')

def firstPass(str,interFile):
  inputFile = open(str,"r")

  global memloc
  global labels
  for line in inputFile:
    line = line.strip()
    if(not line):
      pass
    elif('.text' in line):
      pass
    elif('.global' in line):
      global globvar
      lab,var = line.split(" ")
      globvar = var
    elif('.extern' in line):
      pass
    elif('.end' in line):
      break
    elif('call' in line):
      non,extern = line.split(" ")
      extern = extern[1:] + ".s"
      firstPass(extern,interFile)
    elif(':' in line):
      line = line.strip()[:-1]
      labels[line] = memloc
    else:
      parseCommand(line,interFile)
      memloc += 1

  inputFile.close()

def secondPass():
  global labels
  outputFile = open("MemoryInitialization.mif","w")
  interFile = open("output.txt","r")
  
  for line in interFile:
    if('?' in line):
      old,label = line.split('?')
      num,colon = old.split(' ')
      newnum = int(int(labels[label[:-2]]-1) - int(num[:-1]))
      if(newnum > 0):
        replace = '0' * 16
        replace += bin(newnum)[2:]
        replace = replace[-16:]
        outputFile.write(old + replace + ";\n")
      elif(newnum < 0):
        replace = '1' * 16
        flipped = ''
        bits = bin(newnum)[3:]
        for bit in bits:
          if(bit == '0'):
            flipped += '1'
          else:
            flipped += '0'
        add = int(flipped, 2)
        add += 1
        add = bin(add)[2:]
        replace += ('0'*(len(bits)-len(add)))
        replace += add
        replace = replace[-16:]
        outputFile.write(old + replace + ";\n")
    else:
      outputFile.write(line)

  outputFile.write("END;")
  interFile.close()
  outputFile.close()




interFile = open("output.txt","a+")
firstPass("CatInTheHat.s",interFile)
interFile.close()
secondPass()

print("Complete")
