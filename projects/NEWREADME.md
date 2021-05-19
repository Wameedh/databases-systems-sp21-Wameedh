###### Step by step instructions about how to run the program

To run the program first you need to add the info needed in sqlconfig.conf. These info are:
* host
* username
* password

To run the programe you can run it by using PyCharm by right click on user_interface.py and then "Run"
Or you can run it in the terminal by running the command:

`python3 user_interface.py`

After that you can follow the prompt as I tried to the best I could to explain everything to the user from the beginning of the program until the end. 

The version of the programming language:
I used Python 3.9

###### Challenges that you found (and overcame) during the implementation of this project:

There were many Challenges that I faced when I was implementing this program, some of these Challenges are:
Reading the sql files WholesaleDB.sql which at first my triggers where in that file. Because they were there that means I had two 
different delimiters. I solved this problem by creating a file called trigger.sql and using run_sql_file() function to read it after
reading WholesaleDB.sql then I appended the two readings into one variable called “queries.” Then run the queries all together.  

Note that get_queries_from() takes file and delimiter as inputs and returns queries which is what it reads from the file.



