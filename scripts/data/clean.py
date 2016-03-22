import easyio

if __name__ == '__main__':
  cat_path = 'cat_proverbs.csv'
  dog_path = 'dog_proverbs.csv'
  
  cat_text = easyio.readfile(cat_path)
  dog_text = easyio.readfile(dog_path)

  cat_text = easyio.clean(cat_text)
  dog_text = easyio.clean(dog_text)

  easyio.writefile(cat_path, cat_text)
  easyio.writefile(dog_path, dog_text)