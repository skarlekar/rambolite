# Python program to display all the prime numbers within an interval

# change the values of lower and upper for a different result
lower_def = 1
upper_def = 100

# uncomment the following lines to take input from the user
#lower = int(input("Enter lower range: "))
#upper = int(input("Enter upper range: "))
def handle(req):
    numbers = req.split()
    lower = int(numbers[0])
    upper = int(numbers[1])
    if (lower > upper or lower == upper):
        lower = lower_def
        upper = upper_def
    print("lower = " + str(lower))
    print("upper = "  + str(upper))
    response = prime(lower,upper)
    return response


def prime(lower, upper):
    output = ''
    for num in range(lower,upper + 1):
       # prime numbers are greater than 1
       if num > 1:
           for i in range(2,num):
               if (num % i) == 0:
                   break
           else:
               output = output + ' ' + str(num)
    return output

if __name__ == '__main__':
    print (handle("1 200"))
