from database import get_db_connection

def create_table():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''
                    CREATE TABLE IF NOT EXISTS users (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(255),
                        email VARCHAR(255) UNIQUE
                    )
                   ''')
    conn.commit()
    cursor.close()
    conn.close()

# create_table()