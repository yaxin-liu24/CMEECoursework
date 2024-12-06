
def hello_1(x):
    """
    Prints 'hello' for each number in the range from 0 to x-1 that is divisible by 3.
    
    Args:
    x (int): The upper limit of the range to check.
    
    Example:
    hello_1(12) 
    # Output: 'hello' will be printed for j = 0, 3, 6, 9
    """
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')

hello_1(12)

########################

def hello_2(x):
    """
    Prints 'hello' for each number in the range from 0 to x-1 where the remainder when divided 
    by 5 equals 3, or the remainder when divided by 4 equals 3.
    
    Args:
    x (int): The upper limit of the range to check.
    
    Example:
    hello_2(12) 
    # Output: 'hello' will be printed for j = 3, 7, 8, 11
    """
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')

hello_2(12)

########################

def hello_3(x, y):
    """
    Prints 'hello' for each number in the range from x to y-1.
    
    Args:
    x (int): The starting point of the range.
    y (int): The endpoint of the range (exclusive).
    
    Example:
    hello_3(3, 17) 
    # Output: 'hello' will be printed 14 times (for numbers 3 to 16)
    """
    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)

########################

def hello_4(x):
    """
    Prints 'hello' in a loop while x is not equal to 15. 
    Increments x by 3 on each iteration.
    
    Args:
    x (int): The initial value of x.
    
    Example:
    hello_4(0) 
    # Output: 'hello' will be printed until x reaches 15, incrementing x by 3 each time.
    """
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')

hello_4(0)

########################

def hello_5(x):
    """
    Prints 'hello' in a loop while x is less than 100. If x equals 31, prints 'hello' seven times. 
    If x equals 18, prints 'hello' once. Increments x by 1 after each iteration.
    
    Args:
    x (int): The starting value of x.
    
    Example:
    hello_5(12) 
    # Output: 'hello' will be printed as specified for x = 31 and x = 18, 
    # with normal printing of 'hello' for other values of x.
    """
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')

hello_5(12)

# WHILE loop with BREAK

def hello_6(x, y):
    """
    Prints 'hello' followed by the current value of y in each iteration, 
    incrementing y by 1. The loop terminates when y reaches 6.
    
    Args:
    x (bool): A condition to start the loop (used as a flag, here always True).
    y (int): The starting value of y, incremented on each iteration.
    
    Example:
    hello_6(True, 0) 
    # Output: 'hello' followed by y (0 to 5) will be printed in 6 iterations.
    """
    while x:  # while x is True
        print("hello! " + str(y))
        y += 1  # increment y by 1 
        if y == 6:
            break
    print(' ')

hello_6(True, 0)