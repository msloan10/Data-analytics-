
import math 

def solve(prob):
    count = 0
    for q in range(1,29):#iterate through range of e
        e = q
        count+=1
        for r in range(1, 29):#iterate through range of f
            f = r
            count += 1
            if (e+f+21 >= 23 and e+f+21 <= 50):#c2 #check to see if e+f+21 is within the alowwable ranges of d
                d = e+f+21 
                count+=1
                if (int(((d*d)-417)/ (e*e)) >= 4 and int(((d*d)-417)/ (e*e)) <= 50): #check to see if within allowable ranges of a
                    a = int(((d*d)-417)/ (e*e))
                    count+=1
                    if (d*d == e*e*a+417): #Check if C3 is valid
                        if (e+f< a): #check if C4 is valid 
                            x = -e-f+a #X = b+c (can be equal to each other)
                            if (prob == 'A'):# determine allowable b and c if solving for problem a 
                                if (x %2 == 0):
                                    b = int(x/2)
                                    c = int(x/2)
                                else:
                                    b = int(x/2)+1
                                    c = int(x/2)
                                count+=2
                                print("\nProblem A Solution")
                                print('a:',a, 'b:',b,'c:',c,'d:',d,'e:',e,'f:',f)
                                print('NVA:',count)
                                return True
                            #Problem 2 start      
                            g = int(f-math.sqrt((a+d))) #derived from pre-analysis
                            j = int((g*g+39)/4) # derived from pre-analysis
                            count+= 2
                            if(a+d==(f-g)**2 - 1):# C6 valid?
                                if(4*j==g**2+39):#C7 valid?
                                    for s in range(1,51):# iterate through possible values of s
                                        if (s%4 == 0): # pre-analysis: H%4 == 0
                                            h = s
                                            char_i = int((math.sqrt(h*j+e*12)-g))
                                            count+=2
                                            if (h*j+e*12==(g+char_i)**2): #c5
                                                if ((char_i-g)**9==(f-h)**3):#c8
                                                    for t in range(1,x):
                                                        c = t
                                                        count+=1
                                                        if ((g-c)**2== f*c*c  + 1): #c9
                                                            b = x-c
                                                            count+=1
                                                            if (prob == 'B'):
                                                                print("\nProblem B Solution")
                                                                print('a:',a, 'b:',b,'c:',c,'d:',d,'e:',e,'f:',f, 'g:',g, 'h:',h, 'i:', char_i, 'j:', j)
                                                                print('NVA:',count)
                                                                return True
                                                            #problem c start 
                                                            char_o = int(math.sqrt(g*h*char_i*b +133)) 
                                                            count+=1
                                                            if (char_o**2==g*h*char_i*b + 133):#c13
                                                                for u in range(18,51): #pre-analysis
                                                                    n = u
                                                                    count+=1
                                                                    if ((n-char_o)**3 + 7== (f-char_i)*n): #c11
                                                                        m = int(math.sqrt((n**2)-291))
                                                                        count+=1
                                                                        if(n**2==m**2 + 291):#c12
                                                                            k = int(math.sqrt(m+char_o+10))
                                                                            count+=1
                                                                            if(m+char_o==k**2 -10): #c14
                                                                                if(2*m==k**2 -6): #c10  
                                                                                    for v in range(1, 51):
                                                                                        l = v
                                                                                        count+=1
                                                                                        if (l**3 + char_i==(l+b)*k):#c15
                                                                                            if (prob =='C'):
                                                                                                print("\nProblem C Solution")
                                                                                                print('a:',a, 'b:',b,'c:',c,'d:',d,'e:',e,'f:',f, 'g:',g, 'h:',h, 'i:', char_i, 'j:', j, 'k:', k, 'l:', l, 'm:', m, 'n:', n, 'o:', char_o)
                                                                                                print('NVA:',count)
                                                                                                return True
    print('No solution')
    return False

                                                                           

arr = ['A', 'B', 'C']

print("Task 3 CSP")
prob = input("Choose a Problem to solve (A, B, C): " )

while prob not in arr:
    print('\nInvalid input')
    print('Valid input: A, B, or C \nOnly input a single capital letter')
    prob = input("\nChoose a Problem to solve (A, B, C): " )

solve(prob)
                                                            





