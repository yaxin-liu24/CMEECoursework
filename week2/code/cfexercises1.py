"""
This script provides various mathematical functions including square root calculation, 
finding the larger of two numbers, sorting three numbers, and calculating the factorial 
using different approaches. It interacts with the user to demonstrate the functionality of each function.
"""

def foo_1(x):
    """
    Calculate the square root of a given number.

    Args:
        x (float): The number to calculate the square root of.

    Returns:
        float: The square root of the input number.
    """
    return x ** 0.5

def foo_2(x, y):
    """
    Return the larger of two numbers.

    Args:
        x (float): The first number.
        y (float): The second number.

    Returns:
        float: The larger of the two input numbers.
    """
    if x > y:
        return x
    return y


def foo_3(x, y, z):
    """
    Sort three numbers in ascending order.

    Args:
        x (float): The first number.
        y (float): The second number.
        z (float): The third number.

    Returns:
        list: A list containing the three numbers sorted in ascending order.
    """
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

# Calculate the factorial of a given non-negative integer using an iterative approach.
# Args:
# x (int): The non-negative integer to calculate the factorial of.
# Returns:
# int: The factorial of the input number.
def foo_4(x):
    """
    Calculate the factorial of a given non-negative integer using an iterative approach.

    Args:
        x (int): The non-negative integer to calculate the factorial of.

    Returns:
        int: The factorial of the input number.
    """
    result = 1
    for i in range(1, x + 1):
        result *= i
    return result


# Calculate the factorial of a given non-negative integer using recursion.
# Args:
# x (int): The non-negative integer to calculate the factorial of.
# Returns:
# int: The factorial of the input number.
    
def foo_5(x):  
    """Recursive function to calculate the factorial of x."""
    if x == 1:
        return 1
    return x * foo_5(x - 1)


# Calculate the factorial of a given non-negative integer using a while loop.
# Args:
# x (int): The non-negative integer to calculate the factorial of.
# Returns:
# int: The factorial of the input number.
def foo_6(x):  
    """Calculate the factorial of x using a while loop."""
    facto = 1
    while x >= 1:
        facto *= x
        x -= 1
    return facto


def main():
    """
    Main function to interact with the user and demonstrate the functionality 
    of various mathematical functions provided in this script.
    Prompts the user for input and prints the corresponding output for each function.
    """
    # User inputs for each function
    x1 = float(input("Enter a number for square root calculation: "))
    print(f"Square root of {x1}: {foo_1(x1)}")
    
    x2 = float(input("Enter the first number to compare: "))
    y2 = float(input("Enter the second number to compare: "))
    print(f"Largest number between {x2} and {y2}: {foo_2(x2, y2)}")
    
    x3 = float(input("Enter the first number for sorting: "))
    y3 = float(input("Enter the second number for sorting: "))
    z3 = float(input("Enter the third number for sorting: "))
    print(f"Sorted numbers: {foo_3(x3, y3, z3)}")
    
    x4 = int(input("Enter a number to calculate factorial (iterative): "))
    print(f"Factorial of {x4} (iterative): {foo_4(x4)}")
    
    x5 = int(input("Enter a number to calculate factorial (recursive): "))
    print(f"Factorial of {x5} (recursive): {foo_5(x5)}")
    
    x6 = int(input("Enter a number to calculate factorial (while loop): "))
    print(f"Factorial of {x6} (while loop): {foo_6(x6)}")

if __name__ == "__main__":
    main()