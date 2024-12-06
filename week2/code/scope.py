_a_global = 10  # a global variable

# Print the value of _a_global before calling a_function
print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

# Define a function that demonstrates the use of local and global variables inside a function
def a_function():
    """
    Demonstrates the use of local and global variables inside a function.
    """
    global _a_global  # Referencing the global variable _a_global inside the function
    _a_global = 4  # a local assignment to _a_global (overwrites global value)
    
    _b_global = _a_global + 5  # a local variable
    
    _a_local = 3  # a local variable
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)
    
# Call the function
a_function()

# Print the value of _a_global after calling a_function
print("After calling a_function, outside the function, the value of _a_global is", _a_global)

# -------------------------------------------------------------

# Set _a_global back to its original value
_a_global = 10

def a_function():
    """
    Demonstrates variable scope with local and global variables.
    """
    global _a_global  # Referencing the global variable _a_global
    _a_local = 4  # a local variable
    
    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)
    
# Call the function
a_function()

# Print the value of _a_global after calling a_function
print("Outside the function, the value of _a_global is", _a_global)

# -------------------------------------------------------------

# Set _a_global back to its original value
_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    """
    Demonstrates modifying a global variable inside a function using the `global` keyword.
    """
    global _a_global
    _a_global = 5  # Modify global _a_global inside the function
    _a_local = 4  # a local variable
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value _a_local is", _a_local)
    
# Call the function
a_function()

# Print the value of _a_global after calling a_function
print("After calling a_function, outside the function, the value of _a_global now is", _a_global)

# -------------------------------------------------------------

# Set _a_global back to its original value
_a_global = 10

def a_function():
    """
    Demonstrates modifying a global variable from a nested function.
    """
    _a_global = 10  # Local variable in the outer function

    def _a_function2():
        global _a_global  # Modify the global variable _a_global inside the inner function
        _a_global = 20
    
    print("Before calling _a_function2, value of _a_global is", _a_global)
    
    _a_function2()  # Call the nested function
    
    print("After calling _a_function2, value of _a_global is", _a_global)
    
# Call the function
a_function()

# Print the value of _a_global after calling a_function
print("The value of _a_global in main workspace / namespace now is", _a_global)

# -------------------------------------------------------------

# Set _a_global back to its original value
_a_global = 10

def a_function():
    """
    Demonstrates modifying a global variable from a nested function using `global`.
    """
    def _a_function2():
        global _a_global
        _a_global = 20  # Modify global _a_global inside the nested function
    
    print("Before calling _a_function2, value of _a_global is", _a_global)
    
    _a_function2()  # Call the nested function
    
    print("After calling _a_function2, value of _a_global is", _a_global)

# Call the function
a_function()

# Print the value of _a_global after calling a_function
print("The value of _a_global in main workspace / namespace is", _a_global)
