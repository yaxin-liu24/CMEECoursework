def my_squares(iters):
    """
    Returns a list of squares of numbers from 0 to iters-1.
    
    Args:
    iters (int): The number of iterations.
    
    Returns:
    list: A list of squared values.
    """
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """
    Joins the given string multiple times, separated by commas.
    
    Args:
    iters (int): The number of times to repeat the string.
    string (str): The string to join.
    
    Returns:
    str: The concatenated string.
    """
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x, y):
    """
    Runs my_squares and my_join functions and prints the arguments x and y.
    
    Args:
    x (int): The number of iterations.
    y (str): The string to be joined.
    
    Returns:
    int: Returns 0 after execution.
    """
    print(x, y)
    my_squares(x)
    my_join(x, y)
    return 0

run_my_funcs(10000000, "My string")
