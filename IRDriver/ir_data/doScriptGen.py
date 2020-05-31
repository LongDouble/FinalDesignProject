from random import *

index = 0
arr = [[]]

time_offset = 0
multiplier = 1000000000

for cur_file in range(0, 10):

    f = open(str(cur_file) + '.csv')

    # Initialize first element of arr

    for line in f:
        if line[0] == '-' or line[0].isdigit():
            values = line.split(',')
            for i in range(1, len(values)):
                values[i] = 0 if values[i] < 1 else (1 if values [i] > 4 else 0)
            time_offset -= float(values[0]) * multiplier
            values[0] = float(values[0]) * multiplier + time_offset
            if (cur_file == 0):
                arr[0] = values[:]
            else:
                arr.append(values[:])
            break

    # Look for moments in time where the signals change
    for line in f:
        if line[0] == '-' or line[0].isdigit():
            values = line.split(',')
            new_value = arr[len(arr)-1][:]
            new_value[0] = float(values[0]) * multiplier + time_offset
            for i in range(1, len(values)):
                if float(values[i]) < 1 and arr[len(arr)-1][i] == 1:
                    new_value[i] = 0
                    arr.append(new_value)
                elif float(values[i]) > 4 and arr[len(arr)-1][i] == 0:
                    new_value[i] = 1
                    arr.append(new_value)

    time_offset = arr[len(arr)-1][0] + 5000000 + randrange(10000)

# Format force commands
line = "force signal "
for i in range(0, len(arr)):
    if i != 0:
        line += ", "
    line += str(arr[i][1]) + " @ " + str(int(arr[i][0]))
print(line)

print("run " + str(int(arr[len(arr)-1][0]) + 5000000))
