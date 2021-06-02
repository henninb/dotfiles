import sys
from youtube_search import YoutubeSearch


# results = YoutubeSearch('sound of silence lyrics', max_results=3).to_json()
# results = YoutubeSearch('mozzik_loredana_romeo_and_juliet', max_results=1).to_json()
results = YoutubeSearch(sys.argv[1] + 'lyrics', max_results=1).to_json()

print(results)

# returns a json string

########################################

# results = YoutubeSearch('search terms', max_results=10).to_dict()

# print(results)
# returns a dictionary
