import sys

if (len(sys.argv) != 2):
    print("invalid number of arguments")
    quit()

f = open(sys.argv[1])

arr = [[]]

# Initialize first element of arr
for line in f:
    if line[0] == '-' or line[0].isdigit():
        values = line.split(',')
        for i in range(1, len(values)):
            values[i] = 0 if values[i] < 1 else (1 if values [i] > 4 else 0)
        values[0] = float(values[0])
        arr[0] = values[:]
        break

# Look for moments in time where the signals change
for line in f:
    if line[0] == '-' or line[0].isdigit():
        values = line.split(',')
        new_value = arr[len(arr)-1][:]
        new_value[0] = float(values[0])
        for i in range(1, len(values)):
            if float(values[i]) < 1 and arr[len(arr)-1][i] == 1:
                new_value[i] = 0
                arr.append(new_value)
            elif float(values[i]) > 4 and arr[len(arr)-1][i] == 0:
                new_value[i] = 1
                arr.append(new_value)

# Format force commands
multiplier = 1000000000
offset = 0 - int(arr[0][0] * multiplier)
line = "force a "
for i in range(0, len(arr)):
    if i != 0:
        line += ", "
    line += str(arr[i][1]) + " @ " + str(offset + int(arr[i][0] * multiplier))
print(line)

print("run " + str(offset + int(arr[i][0] * multiplier) + 100))
