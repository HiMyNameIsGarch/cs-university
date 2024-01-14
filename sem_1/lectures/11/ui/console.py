from main import TeamRepository
from domain.Team import Team

repo = TeamRepository(None)

try:
    score = int(input("Enter score: "))
    repo.add_team(Team("Team 1", score))
except:
    print("Invalid score")

# Now I have realized that in one semester we didn't learn about debugging the
# code, it's hilarious.
