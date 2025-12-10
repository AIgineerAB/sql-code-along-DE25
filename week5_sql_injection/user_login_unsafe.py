import duckdb
from constants import DB_PATH

with duckdb.connect(str(DB_PATH)) as conn:
    result = conn.execute("""
        SELECT 
            *
        FROM 
            users
        WHERE
            username = 'bob_the_builder' AND
            password = 'construction99'
    """)
    # if the password is correct 
    # we will get back a record in the list -> truthy

    # if password is wrong -> empty list -> falsey
    
    if result.fetchall():
        print("You can eat all ice creams you want")
    else:
        print("Sorry dude")