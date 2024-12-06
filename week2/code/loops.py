#loops
# for i in range(5):
#     print(i)

# 
# my_list = [0, 2, "geronimo!", 3.0, True, False]
# for k in my_list:
#     print(k)

# total = 0
# summands = [0, 1, 11, 111, 1111]
# for s in summands:
#     total = total + s
#     print(total)
# r = 0
# while r < 100:
#     r= r+1
#     print(r)

#Functions
def foo(x):
    """
    This function takes an integer `x`, squares it, and prints the result. 
    It then returns the squared value, which allows the result to be stored or used later.
    Note:
    If the return statement is omitted, the result of the operation cannot be stored in a variable.
    """
    x *= x  # This is equivalent to x = x * x
    print(x)
    return x  # Return the squared value of x

y = foo(3)
