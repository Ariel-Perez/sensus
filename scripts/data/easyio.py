# -- coding: utf-8 --
import re
import glob
import codecs

def extract_sentences(text):
    """
    Ëxtrae las oraciones de un texto y las retorna en una lista
    """
    return [s.strip('"').strip() for s in text.replace('\r', '\n').split('\n') if len(s.strip()) >= 4]

def extract_words(text):
    """
    Extrae las palabras de un texto y las retorna en una lista
    """
    text = no_tildes(text)
    text = lower(text)

    return re.findall('[a-z\xf1]+', text)

def readfile(path):
    """
    Retorna el texto de un archivo.
    """
    with codecs.open(path, 'r') as f:
        text = f.read()

    return text

def writefile(path, content):
    """
    Escribe un archivo con el contenido dado.
    """
    with codecs.open(path, 'w') as f:
        f.write(content)


def get_files(path = '.', extensions = ['txt']):
    path = correct_path(path)

    query = path + '*[' + ''.join(['(.%s)' % s for s in extensions]) + ']'
    files = glob.glob(query)
    return files

def unigrams(words):
    """
    Crea un diccionario con el conteo de las palabras entregadas.
    Retorna una tupla (lista, dicc) donde lista corresponde a todas las palabras distintas que se agregaron.
    """
    unigram_counts = {}
    unigrams = []
    for word in words:
        unigram_counts[word] = unigram_counts.get(word, 0) + 1
        if unigram_counts[word] == 1:
            unigrams.append(word)

    return (unigrams, unigram_counts)

def correct_path(path):
    """
    Se asegura de que al final del path haya un '/' o '\\'
    """
    if path[-1] == '/' or path[-1] == '\\':
        return path
    return path + ('/' if '/' in path else '\\')

def no_tildes(text):
    # Tildes bien puestos
    text = text.replace('\xe1', 'a')
    text = text.replace('\xe9', 'e')
    text = text.replace('\xed', 'i')
    text = text.replace('\xf3', 'o')
    text = text.replace('\xfa', 'u')

    text = text.replace('\xc1', 'A')
    text = text.replace('\xc9', 'E')
    text = text.replace('\xcd', 'I')
    text = text.replace('\xd3', 'O')
    text = text.replace('\xda', 'U')

    # Tildes para el otro lado
    text = text.replace('\xe0', 'a')
    text = text.replace('\xe8', 'e')
    text = text.replace('\xec', 'i')
    text = text.replace('\xf2', 'o')
    text = text.replace('\xf9', 'u')

    text = text.replace('\xc0', 'A')
    text = text.replace('\xc8', 'E')
    text = text.replace('\xcc', 'I')
    text = text.replace('\xd2', 'O')
    text = text.replace('\xd9', 'U')

    # Puntos:
    text = text.replace('\xe4', 'a')
    text = text.replace('\xeb', 'e')
    text = text.replace('\xef', 'i')
    text = text.replace('\xf6', 'o')
    text = text.replace('\xfc', 'u')

    text = text.replace('\xc4', 'A')
    text = text.replace('\xcb', 'E')
    text = text.replace('\xcf', 'I')
    text = text.replace('\xd6', 'O')
    text = text.replace('\xdc', 'U')

    # ñ
    text = text.replace('\xf1', 'n')
    text = text.replace('\xd1', 'N')

    # Signos de interrogación y exlclamación hacia abajo
    text = text.replace('\xa1', '')
    text = text.replace('\xbf', '')


    return text

def clean(text):
    text = text.lower()
    # text = no_tildes(text)
    text.replace(u',', u' ')
    text.replace(u'.', u' ')
    lines = text.split('\n')
    new_lines = []
    for line in lines:
        new_lines.append(u' '.join(re.findall(u'[a-z0-9\n]+', line)).strip())
    text = u'\n'.join(new_lines)
    return text

def lower(text):
    text = text.replace('\xd1', '\xf1')
    text = text.lower()

    return text