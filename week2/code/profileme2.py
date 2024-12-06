def my_squares(iters):
    """
    Returns a list of squares of numbers from 0 to iters-1.
    
    Args:
    iters (int): The number of iterations.
    
    Returns:
    list: A list of squared values from 0 to (iters-1).
    """
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """
    Joins the given string multiple times, each separated by a comma and a space.
    
    Args:
    iters (int): The number of times to repeat the string.
    string (str): The string to join.
    
    Returns:
    str: The concatenated string, with each repetition separated by ", ".
    """
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x, y):
    """
    Runs the `my_squares` and `my_join` functions with the provided arguments, 
    and prints the arguments `x` and `y`.
    
    Args:
    x (int): The number of iterations.
    y (str): The string to be repeated.
    
    Returns:
    int: Returns 0 after executing the functions.
    """
    print(x, y)
    my_squares(x)
    my_join(x, y)
    return 0

run_my_funcs(10000000, "My string")
