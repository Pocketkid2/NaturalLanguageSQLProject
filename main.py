import sqlite3
from openai import OpenAI

debug = False

client = OpenAI()
conn = sqlite3.connect('movies.db')

prompt_A_extra = "-- Using valid SQLite, answer the following questions for the tables provided above. Do not respond with any words or sentences, just the SQL query that answers the question. Do not format it as code. If the question asks for movies or users, make sure the title or username is included in the query output. \n\n"

def get_response(prompt):
    return client.chat.completions.create(
        model="gpt-4-turbo",
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt},
        ]
    )

def main():
    with open('prompt_sql_help.sql', 'r') as sql_syntax_file:
        sql_syntax = sql_syntax_file.read() 
        c = conn.cursor()
        while True:
            # Step 1 - Read prompt
            prompt = input("\nType your question: ")

            # Step 2 - Exit if needed
            if prompt.lower() == 'exit':
                break

            # Step 3 - Convert natural language to SQL using OpenAI
            prompt_A = sql_syntax + prompt_A_extra +  "Question: " + prompt
            response = get_response(prompt_A)
            sql_query = response.choices[0].message.content
            if debug:
                print("\n\nSQL Query: ", sql_query, "\n")                                          

            # Step 4 - Execute SQL query
            c.execute(sql_query)

            # Step 6 - Convert results to string
            column_names = [description[0] for description in c.description]                                    # Get the column names
            column_names_str = 'Table Columns: ' + ', '.join(column_names)                                      # Convert the column names to a string
            rows = c.fetchall()                                                                                 # Fetch all the rows
            rows_str = '\n'.join(', '.join(str(item) for item in row) for row in rows)                          # Convert the rows to strings
            result_str = column_names_str + '\n' + f'Number of result table rows: {len(rows)}\n' + rows_str     # Combine the column names and rows into one string
            if debug:
                print("\n\nSQL Result: " + result_str)                                              

            # Step 7 - Ask OpenAI to convert the SQL result to natural language
            prompt_B = sql_syntax + "-- The preceding SQLite table schema was used to answer this natural language question with this SQL query\n" + "Question: " + prompt + "\n" + "SQL Query: " + sql_query + "\n" + "Result: " + result_str + "\n\n" + "Convert this response into natural language as clearly and succinctly as possible. Only answer with that natural language translation."
            response = get_response(prompt_B)
            natural_language_response = response.choices[0].message.content
            if debug:
                print("\n\nNatural Language Response: ", natural_language_response, "\n")
            else:
                print(natural_language_response)

            
        conn.close()

if __name__ == '__main__':
    main()