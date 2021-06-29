yarn global add deepl-translator-cli

# Translate text into German
$ deepl translate -t 'DE' 'How do you do?'

# Pipe text from standard input
$ echo 'How do you do?' | deepl translate -t 'DE'

# Detect language
$ deepl detect 'Wie geht es Ihnen?'

$ wget git.io/trans
$ chmod +x ./trans
