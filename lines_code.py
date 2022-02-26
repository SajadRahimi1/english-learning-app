import os

count = 0
max = 0
maxFile = ""
# get list of files in lib directory
for root, directories, files in os.walk("./lib", topdown=False):
    for name in files:
        file = open(os.path.join(root, name), encoding="utf8")
        # get line of file
        lineFile = 0
        for line in file:
            if line != "\n":
                count += 1
                lineFile += 1
        if lineFile > max:
            max = lineFile
            maxFile = name
        file.close()
print("Number of lines of code:", count)
print("File with most lines of code:", maxFile)
print("Number of lines of code in file with most lines of code:", max)
add_str = f"""
## Count lines of codes: {count}
## File with most lines of code: {maxFile}
## Most lines of code in one file: {max}
"""


def prepend_line():
    # define name of temporary dummy file
    dummy_file = "README.md" + '.bak'
    # open original file in read mode and dummy file in write mode
    with open("README.md", 'r') as read_obj, open(dummy_file, 'w') as write_obj:
        # Write given line to the dummy file
        write_obj.write(add_str + '\n')
        # Read lines from original file one by one and append them to the dummy file
        for line in read_obj:
            write_obj.write(line)
    os.remove("README.md")
    # Rename dummy file as the original file
    os.rename(dummy_file, "README.md")


prepend_line()
