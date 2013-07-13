#!/usr/bin/python

from pylab import *

lidi=['Vera','Konstantin', 'Rut', 'Linda', 'Waldemar']
zdroje=['bugemos', 'technet', 'osel', 'xkcd', 'root',
        'abclinuxu', 'zdrojak', 'webylon', 'interval']

spojeni={'Vera': ['bugemos', 'technet'],
         'Konstantin': ['technet', 'osel', 'xkcd'],
         'Rut': ['technet', 'xkcd', 'root', 'abclinuxu'],
         'Linda': ['root', 'zdrojak'],
         'Waldemar': ['xkcd', 'zdrojak', 'webylon', 'interval']}

matice=[]
for i in range(len(lidi)):
    radek = [0]*len(zdroje)
    for z in spojeni[lidi[i]]:
        zdroj = zdroje.index(z)
        radek[zdroj] = 1
    matice.append(radek)

matice = matrix(matice)
# print(matice)

def makeC(mat):
    vysledek = []
    s = mat.sum(1)
    
    for i in range(len(s)):
        vysledek.append((mat[i]/s[i]).getA1())
    return matrix(vysledek)

def makeB(mat):
    return makeC(matice.transpose()).transpose()

Ct = makeC(matice).transpose()
B = makeB(matice)

CR0 = eye(len(lidi))

CR = CR0.copy()

def rem(m1, m2):
    vysledek = []
    for i in range(len(lidi)):
        radek = []
        for j in range(len(zdroje)):
            radek.append(0 if m2[i,j] else m1[i,j])
        vysledek.append(radek)
    return matrix(vysledek)

def zhodnot(pr, matice):
    mat = rem(PR, matice)
    for i in range(len(lidi)):
        clovek = lidi[i]
        print(clovek)
        print(spojeni[clovek])
        zd = [(mat[i, j], zdroje[j]) for j in range(len(zdroje))]
        zdr = sorted(zd, key= lambda z: -z[0])
        print([""+zdr[j][1]+" ("+str(round(zdr[j][0], 1))+")" for j in range(3)])

for i in range(10):
    PR = CR * B
    CR = PR * Ct + CR0
    
zhodnot(PR, matice)
