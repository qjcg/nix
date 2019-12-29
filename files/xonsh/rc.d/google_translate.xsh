import urllib


def _say(args, stdin=None):
    """Text to speech via Google Translate TTS API.
    """
    if stdin:
        words = [l.rstrip() for l in stdin]
        words = ' '.join(words)
    else:
        words = ' '.join(args)

    wordsq = urllib.parse.quote(words)

    TTS_URL = f'https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&tl=en&q={wordsq}'
    curl -s -H 'Referer: http://translate.google.com/' -H 'User-Agent: xonshsay/0.1.0' @(TTS_URL) | /usr/bin/mpv --really-quiet -

    return words, None


aliases['say'] = _say
