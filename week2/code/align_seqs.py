#os: provides a way to use operating system-dependent functionality, such as file path manipulation and directory creation.
import os
# Reads the first two non-empty lines from a specified file, treating them as sequences.
def read_sequences(filename):
    with open(filename, 'r', encoding='utf-8') as file:
        seq1 = file.readline().strip()
        seq2 = file.readline().strip()
        if not seq1 or not seq2:
# Checks if either sequence is empty and raises a ValueError if so
            raise ValueError("File must contain at least two sequences.")
        return seq1, seq2
# Compares two sequences starting from a given index and returns a string indicating matches and a score.
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = ""
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]:
# appends * to matched and increments the score. If not, appends -
                matched += "*"
                score += 1
            else:
                matched += "-"
    return matched, score
# Finds the best alignment of seq1 and seq2 by shifting seq2 across seq1 and calculating the score.
def find_best_alignment(seq1, seq2):
    l1, l2 = len(seq1), len(seq2)
    s1, s2 = seq1, seq2
    if l1 < l2:
        s1, s2 = s2, s1
        l1, l2 = l2, l1
    
    my_best_align = None
    my_best_score = -1
# Calls calculate_score for each position and updates the best alignment and score if the current score is higher.
    for i in range(l1 - l2 + 1):
        matched, score = calculate_score(s1, s2, l1, l2, i)
        if score > my_best_score:
            my_best_align = "." * i + s2
            my_best_score = score
    
    return my_best_align, s1 if l1 >= len(seq1) else seq2, my_best_score

# Opens the specified output file in write mode.
# Writes the best alignment, the sequence, and the best score in a structured format.
def write_output(best_align, seq1, best_score, output_filename):
    with open(output_filename, 'w', encoding='utf-8') as f:
        f.write("Best alignment:\n")
        f.write(best_align + "\n")
        f.write(seq1 + "\n")
        f.write(f"Best score: {best_score}\n")

# This block runs when the script is executed directly.
# Sets input and output directory paths.
# Uses os.makedirs to ensure the output directory exists.
# Constructs the full output file path.
# Calls read_sequences to get the two sequences from the input file.
# Calls find_best_alignment to compute the best alignment.
# Calls write_output to save the results.
# Catches and prints any exceptions that occur during the process.
if __name__ == "__main__":
    input_dir = '../data'
    input_filename = os.path.join(input_dir, 'sequences.csv')
    output_dir = '../results'
    output_filename = 'best_alignment.txt'
    
    # Create the output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    # Construct the full path for the output file
    output_path = os.path.join(output_dir, output_filename)
    
    try:
        seq1, seq2 = read_sequences(input_filename)
        best_align, seq1, best_score = find_best_alignment(seq1, seq2)
        write_output(best_align, seq1, best_score, output_path)
        print(f"Best alignment saved to '{output_path}'.")
    except Exception as e:
        print(f"An error occurred: {e}")
