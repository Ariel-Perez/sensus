var Category = function(id, name, count) {
  Category.incrementalId = Category.incrementalId || 1;

  this.id = id || Category.incrementalId;
  this.name = name || '';
  this.count = count || 0;

  Category.incrementalId = Math.max(Category.incrementalId, this.id + 1);
};

var data = {
  categories: [
    new Category(1, 'Docencia', 0),
    new Category(2, 'Infraestructura', 0),
  ],
  queries: [
    'TODO FUNCIONA IMPECABLE, DERREPENTE FALLAN ALGUNOS DOCENTES.',
    'LO UNICO QUE NO ME GUSTA ES LO PEQUENO DE LA BIBLIOTECA Y CASINO PARA TANTOS ALUMNOS.',
    'PROFESORES CON FALTA DE SENTIDO COMUN, FALTA DE SABIDURIA, MUY EXAGERADOS. POCO EMPATICOS CON LOS ALUMNOS.',
    'ES MUY LENTO',
    'LA EXPERIENCIA HA SIDO SATISFACTORIA EN GENERAL COMO SERVICIO, PERO LA CALIDAD NO ES LA ESPERADA. LA CALIDAD DE LOS PROFESORES, ES LA CALIDAD DE LOS ALUMNOS',
    'POR LAS OPORTUNIDADES BRINDADAS POR LA INSTITUCION Y CALIDAD HUMANA DE CIERTOS PROFESORES',
    'POR QUE EN GENERAL ES MUY BUENA UNIVERSIDAD',
    'CUANDO NECESITO ALGO NO SIEMPRE ESTAN DISPONIBLES O LAS RESPUESTAS LA DAN ASI COMO ASI',
    'EXCELENTE LUGAR, GRATO AMBIENTE, LIMPIO Y ORDENADO.',
    'POR QUE POSEE BUENOS ESPACIOS, PERO PODRIA SER MEJOR.',
  ]
};
var classifications = {};

ready = function() {
  $('.canvas').empty();
  window.newClassId = 0;
  window.queryIndex =-1;

  var wHeight = $(window).height();
  var wWidth = $(window).width();
  var discSize = wHeight - 75;
  var discCenterSize = discSize / 2;
  var satelliteSize = discSize / 4 - 10;

  window.disc = new Disc(new Point(discSize / 2, discSize / 2), discCenterSize, discSize);
  window.add = new Satellite(disc.position, satelliteSize, {'class': 'add'});

  add.satellite.click(function() {
    var sat = createCategorySatellite(add.position, add.size);
    disc.appendSatellite(sat);
  });

  $('.canvas').append(disc.disc);

  disc.appendSatellite(add);

  setupQuestionSelect();
  $('#training-next').click(next);
  $('#training-previous').click(previous);
}

$(document).ready(ready);
$(document).on('page:load', ready);;

function setupQuestionSelect()
{
  $('#question-select').change(function() {
    var id = $(this).val();
    ajaxCallback('/questions/' + id + '/answers.json',
      {'filter': 'unseen'},
      function(data) {
        window.data['queries'] = [];
        data.forEach(function(element) {
          window.data['queries'].push(element.text);
          window.queryIndex = -1;
          next();
        });
      }, 'GET');
    ajaxCallback('/questions/' + id + '/categories.json',
      {}, function(data) {
        $('.canvas .category').remove();
        window.data.categories = [];
        window.disc.satellites = [window.disc.satellites[0]];
        data.forEach(function(element) {
          category = new Category(element.id, element.name, 0);
          window.data.categories.push(category)
          disc.appendSatellite(
            createCategorySatellite(disc.position, add.size, category));
        });
        console.log(data);
      }, 'GET');
  });
  $('#question-select').change();
}

function createCategorySatellite(position, size, category) {
  var sat = new Satellite(position, size, {'class': 'category'});

  if (category === undefined) {
    category = new Category();
    window.data['categories'].push(category);
  }

  linkCategory(sat, category);

  return sat;
}

function linkCategory(satellite, category) {
  var placeholder = 'Categoría';
  var label = $(satellite.circle).find('.label');
  var input = $('<input type="text"></input>');
  input.attr('placeholder', placeholder);
  input.val(category.name);
  if (category.name) {
    input.attr('readonly', '');
  }
  label.append(input);

  input.dblclick(function(event) {
    input.removeAttr('readonly');
    event.stopImmediatePropagation();
  });
  input.click(function(event) {
    if (!input.is('[readonly]')) {
      event.stopImmediatePropagation();
    }
  });
  input.focusout(function(event) {
    if (input.val()) {
      input.attr('readonly', '');
    }
  });
  input.change(function() {
    category.name = input.val();
    if (input.val()) {
      input.attr('readonly', '');
    }
  });
  input.keyup(function (e) {
    if (e.keyCode == 13) {
      input.blur();
    }
  });

  satellite.circle.attr('data-count', category.count);
  satellite.circle.attr('data-id', category.id);
  satellite.circle.click(function() {
    toggleClassification(category.id);
  });

  satellite.setText = function(text) {
    input.val(text);
    category.name = input.val();
  };
}

function setQueryIndex(index) {
  console.log(index);
  console.log(window.data.queries);
  if (0 <= index && index < data.queries.length) {
    $('.classified').removeClass('classified');
    disc.setText(data.queries[index]);
    if (classifications[index] === undefined) {
      classifications[index] = [];
    } else {
      classifications[index].forEach(function(id) {
        var satellite = $('[data-id=' + id + ']');
        satellite.addClass('classified');
      });
    }
    $('#query-index').text(index);
    queryIndex = index;
  }
  if (queryIndex <= 0) {
    $('#training-previous').attr('disabled', true);
  } else {
    $('#training-previous').removeAttr('disabled');
  }
  if (queryIndex >=  data.queries.length - 1) {
    $('#training-next').attr('disabled', true);
  } else {
    $('#training-next').removeAttr('disabled');
  }
}

function next() {
  setQueryIndex(queryIndex + 1);
}
function previous() {
  setQueryIndex(queryIndex - 1);
}

function toggleClassification(id) {
  if (0 <= queryIndex && queryIndex < data.queries.length) {
    var satellite = $('[data-id=' + id + ']');
    var classified = satellite.hasClass('classified');
    if (classified) {
      satellite.attr('data-count', --data.categories[id - 1].count);
      satellite.removeClass('classified');
      idx = classifications[queryIndex].indexOf(id);
      if (idx !== -1) {
        classifications[queryIndex].splice(idx, 1);
      }
    } else {
      satellite.attr('data-count', ++data.categories[id - 1].count);
      satellite.addClass('classified');
      classifications[queryIndex].push(id);
    }
  }
}