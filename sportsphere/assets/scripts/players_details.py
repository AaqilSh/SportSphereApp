import requests
import json

API_KEY = "a0ae70bf7c6687247992d15ddff92bfb"
LEAGUE_ID = 88  # Premier League
SEASON = 2023
BASE_URL = "https://v3.football.api-sports.io"
HEADERS = {"x-apisports-key": API_KEY}

def fetch_teams(league_id, season, limit=10):
    url = f"{BASE_URL}/teams?league={league_id}&season={season}"
    response = requests.get(url, headers=HEADERS)
    return response.json()["response"][:limit] if response.status_code == 200 else []

def fetch_players(team_id, season):
    players, page = [], 1
    while True:
        url = f"{BASE_URL}/players?team={team_id}&season={season}&page={page}"
        response = requests.get(url, headers=HEADERS)
        data = response.json()
        if response.status_code != 200 or not data["response"]:
            break
        players.extend(data["response"])
        page += 1
    return players

def fetch_league_data():
    league_data = {}
    teams = fetch_teams(LEAGUE_ID, SEASON)
    for team in teams:
        team_id, team_name = team["team"]["id"], team["team"]["name"]
        print(f"Fetching players for {team_name}...")
        league_data[team_name] = fetch_players(team_id, SEASON)

    with open("Eredivisie.json", "w", encoding="utf-8") as file:
        json.dump(league_data, file, indent=4, ensure_ascii=False)
    print("Premier League data saved to premier_league.json")

if __name__ == "__main__":
    fetch_league_data()
