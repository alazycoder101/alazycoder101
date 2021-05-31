# using the collection method
def my_sum (my_collection):
    result = 0
    for x in my_collection:
        result += x

    return result

list_of_numbers = [1, 2, 3]
print(my_sum(list_of_numbers)) 
# outputs : 5


# using the python `*` unpacking operator
def my_sum2(*args):
    result = 0
    # Iterating over the Python args tuple
    for x in args:
        result += x
    return result

print(my_sum2(1, 2, 3)) #outputs : 5

def concatenation (**kwargs):
    result = ""
    # Iterating over the kwargs dictionary
    for arg in kwargs.values():
        result += arg + " "
    return result

print(concatenation(a="ML and AI", b="in Python", c="Is", d="Great", e="!"))
#outputs: ML and AI in Python Is Great !


my_list = [1, 2, 3]
print(*my_list) #outputs: 1 2 3

first_list = [1, 2, 3]
second_list = [4, 5, 6]
merged_list = [*first_list, *second_list]
print(merged_list) #outputs: [1, 2, 3, 4, 5, 6]

person_1 = {"name1": "Victor", "age1": 16}
person_2 = {"name2": "Linda", "age2": 23}
persons_dict = {**person_1, **person_2}
print(persons_dict)

