
# create_journal_entry.py
import datetime

def create_journal_entry():
    # Script to create a development journal entry
    date = datetime.datetime.now().strftime("%Y-%m-%d")
    with open(f"../journals/development_journal_{date}.md", 'w') as file:
        file.write(f"# Development Journal Entry - {date}\n\n")
        file.write("## Summary\n")
        file.write("Details of the changes made.
")
