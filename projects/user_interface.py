"""
This is the user interface where the program interacts with the user.
USAGE: 1. Go to sqlconfig.conf file and change the username and password
          values to the ones from you are using in your mysql instance
       2. Open a terminal windows and run the following command:
       python3 user_interface.py
NOTE: Only option 3 and 4 from the menu is implemented so students can
      understand the flow of the program as a base to
      implement the rest of the options
"""


def show_menu():
    """
    Prints in console the main menu
    :return: VOID
    """
    print("User Menu \n"
          "1. Create Account \n"
          "2. Login \n"
          "3. Search \n"
          "4. Insert \n"
          "5. Update \n"
          "6. Delete \n"
          "7. Exit \n")


def show_table_names(tables):
    """
    Show all the tables names
    :param tables: a list with the tables names.
                   You can get it by calling the method
                   get_table_names() from DB object
    :return: VOID
    """
    index = 1
    print("\nTables:")
    for table in tables:
        print("{}. ".format(index)+table[0])  # print tables names
        index += 1

# Reversing a list using reversed()
def reverse(tuples):
    new_tup = ()
    for k in reversed(tuples):
        new_tup = new_tup + (k,)
    return new_tup

def checkIfUser(db_object):
    account_id = db_object.ACCOUNT_ID
    query = """SELECT description FROM Role WHERE role_id = %(account_id)s"""
    value = {'account_id': account_id}
    user = db_object.select(query=query, values=value)
    userType = user[0][0]
    if userType[0][0] == "admin":
        return False
    elif userType == "user":
        return True

def option1(db_object):
    """
    :param db_object: database object
    """
    try:
        account_type = input("\nEnter 1 to create an admin account or 0 for a regular account: ")
        if account_type == '0' or account_type == '1':
            firstname = input("\nEnter first name: ")
            lastname = input("\nEnter last name: ")
            email = input("\nEnter email: ")
            password = input("\nEnter password: ")

            attributes_str = "user_email,first_name,last_name"
            values_str = email+","+firstname+","+lastname

            # from string to list of attributes and values
            if "," in attributes_str:  # multiple attributes
                attributes = attributes_str.split(",")
                values = values_str.split(",")
            else:  # one attribute
                attributes = [attributes_str]
                values = [values_str]

            if db_object.insert(table="User", attributes=attributes, values=values):
                sql = """UPDATE Credentials SET password = "%(password)s" WHERE user_email = "%(email)s" """
                val = {'password': password, 'email': email}
                if db_object.update(sql, val):
                    if int(account_type) == 1:
                        query = """SELECT user_id FROM `User` WHERE user_email = %(email)s"""
                        val = {'email': email}
                        userId = db_object.select(query=query, values=val)
                        role_id = userId[0][0]
                        query = """UPDATE Role SET description = "admin" WHERE role_id = %(userId)s """
                        val = {'userId': role_id}
                        db_object.update(query, values=val)
                    print("Account successfully created!\n")
        else:
            print("Please enter 0 for creating a regular account or 1 to create an admin account!")
    except Exception as err:  # handle error
        print("Something went wrong when trying to sign up, please check your info and try again\n")

def option2(db_object):
    try:
        email = input("\nEmail: ")
        password = input("\nPassword: ")
        # query to get get/check user credentials
        sql = """SELECT * FROM Credentials WHERE user_email = %(email)s AND password = %(password)s"""
        val = {'email': email, 'password': password}
        result = db_object.select(sql, values=val)
        # query to get user id from Account
        sql = """SELECT user_id FROM Account WHERE account_id = %s"""
        value = (result[0][1],)
        userID = db_object.select(sql, values=value)
        # query to get username from User
        sql = """SELECT first_name FROM `User` WHERE user_id = %s"""
        val = (userID[0][0],)
        username = db_object.select(sql, values=val)
        db_object.STATE = 1
        db_object.ACCOUNT_ID = userID[0][0]
        db_object.USERNAME = username[0][0]
        print("You are logged as {}!".format(username[0][0]))
    except Exception as err:  # handle error
        print("Something went wrong when trying to log in, please check your credentials and try again\n")

def option3(db_object, tables):
    """
    Search option
    :param db_object: database object
    :param tables: the name of the tables in the database
    :return: VOID
    """
    try:
        if db_object.STATE == 0:
            print("You need to login first!")
        else:
            # shows that tables names in menu
            if checkIfUser(db_object):
                account_id = (db_object.ACCOUNT_ID,)
                query = """SELECT `table_name` FROM Permissions WHERE account_id = %s"""
                tables = db_object.select(query=query, values=account_id)

            print("Tables with write/read permissions for {}.".format(db_object.USERNAME))
            show_table_names(tables)
            # get user input1
            table_selected = None
            table_number = input("\nSelect a table number to search: ")
            try:
                table_selected = int(table_number)
            except ValueError:
                print("Invalid input! You need to enter number of table")
                return
            attribute_selected = input("Search by attribute (i.e user_name or date_of_birth): ")
            value_selected = input("Enter the value: ")

            tableIndex = table_selected - 1
            table_name = tables[tableIndex][0]
            columns = reverse(db_object.get_column_names(table_name))  # get columns names for the table selected and reverse the order
            # build queries with the user input
            query = """SELECT * FROM {} WHERE {} = %(value_selected)s """.format(table_name, attribute_selected)
            value = {'value_selected': value_selected }
            # get the results from the above query
            results = db_object.select(query=query, values=value)
            column_index = 0
            # print results
            print("\n")
            print("Results from: " + table_name)
            for column in columns:
                values = []
                for result in results:
                    values.append(result[column_index])
                print("{}: {}".format(column[0], values) ) # print attribute: value
                column_index+= 1
            print("\n")
    except Exception as err:  # handle error
        print("The data requested couldn't be found\n")

# option 4 when user selects insert
def option4(db_object, tables):

    try:
        if db_object.STATE == 0:
            print("You need to login first!")
        # show tables names
        elif not checkIfUser(db_object):
            show_table_names(tables)
            # get user input for insert
            table_selected = None
            table_number = input("\nEnter a table number to insert data: ")
            try:
                table_selected = int(table_number)
            except ValueError:
                print("Invalid input! You need to enter number of table")
                return
            attributes_str = input("Enter the name of attribute/s separated by comma? ")
            values_str = input("Enter the values separated by comma: ")
            tableIndex = table_selected - 1
            table_name = tables[tableIndex][0]
            # from string to list of attributes and values
            if "," in attributes_str:  # multiple attributes
                attributes = attributes_str.split(",")
                values = values_str.split(",")
            else:  # one attribute
                attributes = [attributes_str]
                values = [values_str]

            if db_object.insert(table=table_name, attributes=attributes, values=values):
                print("Data successfully inserted into {} \n".format(table_name))
        else:
            print("Permission to INSERT is granted only to admins!")

    except: # data was not inserted, then handle error
        print("Error:", values_str, "failed to be inserted in ", table_name, "\n")


def option5(db_object, tables):
    # UPDATE
    try:
        if db_object.STATE == 0:
            print("You need to login first!")
        else:
            if checkIfUser(db_object):
                account_id = (db_object.ACCOUNT_ID,)
                query = """SELECT `table_name` FROM Permissions WHERE account_id = %s"""
                tables = db_object.select(query=query, values=account_id)

            print("\nTables with write/read permissions for {}:".format(db_object.USERNAME))
            show_table_names(tables) # show tables' names
            # get user
            table_selected = None
            table_number = input("\nEnter a table number to insert data: ")
            try:
                table_selected = int(table_number)
            except ValueError:
                print("Invalid input! You need to enter number of table")
                return
            attributes_str = input("Enter the name of attribute  (i.e user_name or date_of_birth): ")
            values_str = input("Enter new value: ")
            old_values_str = input("Enter old value: ")
            tableIndex = table_selected - 1
            table_name = tables[tableIndex][0]
            #values = {'table_name': table_name, 'attributes_str': attributes_str, 'values_str': values_str}
            #query = """UPDATE %(table_name)s SET %(attributes_str)s = "%(values_str)s" WHERE user_name = "wameedh" """
            # db_object.update(query, values)

            query = """UPDATE {} SET {} = %s  WHERE {} = %s""".format(table_name, attributes_str, attributes_str)
            values = [values_str, old_values_str]
            db_object.update(query, values)
            print("Data successfully updated in {}!.".format(table_name))
    except:  # data was not inserted, then handle error
        print("Error:", attributes_str, "failed to be UPDATED in ", table_name, "\n")


def option6(db_object, tables):
    try:
        if db_object.STATE == 0:
            print("You need to login first!")
        else:
            account_id = db_object.ACCOUNT_ID
            row_id = ""
            isUser = checkIfUser(db_object)
            attributes_str = None
            value_of_attribute_str = None
            if isUser:
                acc_id = (db_object.ACCOUNT_ID,)
                query = """SELECT `table_name` FROM Permissions WHERE account_id = %s"""
                tables = db_object.select(query=query, values=acc_id)

            print("\nTables with DELETE permissions for {}:".format(db_object.USERNAME))
            show_table_names(tables)  # show tables' names
            print("Note: you can only delete data associated with your account if you are not an admin.\n")
            # get user input
            table_selected = None
            table_number = input("\nEnter a table number to DELETE data from: ")
            try:
                table_selected = int(table_number)
            except ValueError:
                print("Invalid input! You need to enter number of table")
                return

            if not isUser:
                attributes_str = input("Enter the name of the attribute to be used in WHERE clause (i.e profile_id or account_id): ")
                value_of_attribute_str = input("Enter value of the attribute: ")

            checking_user_decision = input("Are you sure that you want to delete the data? Enter y to confirm or anything else to abort: ")
            checking_user_decision.lower()
            if checking_user_decision == "y":
                tableIndex = table_selected - 1
                table_name = tables[tableIndex][0]
                if not isUser:
                    query = """DELETE FROM {} WHERE %s = %s""".format(table_name)
                    values = [attributes_str, value_of_attribute_str]
                    db_object.delete(query, values)
                    print("Data has been deleted successfully from table: ", table_name, "\n")
                else:
                    if table_name == "Account":
                        row_id = "account_id"
                        # delete account means delete user.
                        # rest the folowing:
                            # STATE = 0
                            # ACCOUNT_ID = None
                            # USERNAME = None
                        db_object.ACCOUNT_ID = None
                        db_object.USERNAME = None
                        db_object.STATE = 0
                   # delete from AccountHasAddresses when user select address
                    elif table_name == "Addresses":
                        table_name = "AccountHasAddresses"
                        row_id = "account_id"
                   # delete from PaymentMethod when user select BankAccount and CreditCard
                    elif table_name == "BankAccount" or table_name == "CreditCard":
                        table_name = "PaymentMethod"
                        row_id = "user_id"

                    query = """DELETE FROM {} WHERE {} = {}""".format(table_name, row_id, account_id)
                    # values = [attributes_str, value_of_attribute_str]
                    db_object.delete(query)
                    if table_name == "Account":
                        print("User and all related data has been deleted!! That means you are not logged in the system!\n")
                    else:
                        print("Data has been deleted successfully from table: ", table_name, "\n")
            else:
                print("Delete aborted!")
    except:  # data was not inserted, then handle error
        print("Error:", "failed to delete data from table: ", table_name, "\n")

##### Driver execution.....
from database import DB

print("Setting up the database......\n")

# DB API object
db = DB(config_file="sqlconfig.conf")

# create a database (must be the same as the one is in your config file)
database = 'WholesaleDB'
state_of_database = True
tables = []
drop_database = input("Do you want to drop and recreate the database, enter y for yes or n for no?\nThis will delete all existing data!\nIf this is your first time running the program then choose y: ")
drop_database.lower()

if drop_database == "y":
    state_of_database = True
elif drop_database == "n":
    state_of_database = False
else:
    print("Wrong input!")
    exit()

if db.create_database(database=database, drop_database_first=state_of_database):
    print("Created database {}".format(database))
else:
    print("An error occurred while creating database {} ".format(database))

if state_of_database:
    # create all the tables from WholesaleDB.sql
    db.run_sql_file("WholesaleDB.sql")
    # insert sample data from insert.sql
    db.run_sql_file("insert.sql")

tables = db.get_table_names()
db.PROGRAME_STARTED = True
print("\nSet up process finished\n")
show_menu()
option = int(input("Select one option from the menu: "))
while option != 7:
    if option == 1:
        option1(db)  # create your account
    elif option == 2:
        option2(db)  # login1
    elif option == 3:
        option3(db, tables)
    elif option == 4:
        option4(db, tables)
    elif option == 5:
        option5(db, tables)
    elif option == 6:
        option6(db, tables)
    show_menu()
    option = int(input("Select one option from the menu: "))

# Example output for insert and search

"""
Setting up the database......

Created database musicsampledb
8 Executed queries from WholesaleDB.sql
29 Executed queries from insert.sql

Set up process finished

User Menu 
1. Create Account 
2. Login 
3. Search 
4. Insert 
5. Update 
6. Delete 
7. Exit 

Select one option from the menu: 4

Tables:
Album
Artist
Genre
Track

Enter a table to insert data: artist
Enter the name attribute/s separated by comma? id, name
Enter the values separated by comma: 7, Nina
Data successfully inserted into artist 

User Menu 
1. Create Account 
2. Login 
3. Search 
4. Insert 
5. Update 
6. Delete 
7. Exit 

Select one option from the menu: 4

Tables:
Album
Artist
Genre
Track

Enter a table to insert data: genre
Enter the name attribute/s separated by comma? description
Enter the values separated by comma: Hip Hop
Data successfully inserted into genre 

User Menu 
1. Create Account 
2. Login 
3. Search 
4. Insert 
5. Update 
6. Delete 
7. Exit 

Select one option from the menu: 3

Tables:
Album
Artist
Genre
Track

Select a table to search: artist
Search by (i.e name)? name
Enter the value: Nina


Results from: artist
id: [7]
name: ['Nina']


User Menu 
1. Create Account 
2. Login 
3. Search 
4. Insert 
5. Update 
6. Delete 
7. Exit 

Select one option from the menu: 3

Tables:
Album
Artist
Genre
Track

Select a table to search: genre
Search by (i.e name)? description
Enter the value: Hip Hop


Results from: genre
id: [6]
description: ['Hip Hop']


User Menu 
1. Create Account 
2. Login 
3. Search 
4. Insert 
5. Update 
6. Delete 
7. Exit 

Select one option from the menu: 
"""