var Category = function(id, name, count) {
  Category.incrementalId = Category.incrementalId || 1;

  this.id = id || Category.incrementalId;
  this.name = name || '';
  this.count = count || 0;

  Category.incrementalId = Math.max(Category.incrementalId, this.id + 1);
};

var data = {
  categories: [
    new Category(1, 'Docencia', 3),
    new Category(2, 'Infraestructura', 2),
  ],
  queries: [
    'Los profesores son muy buenos',
    'Las salas se gotean',
    'Más áreas verdes',
    'La comida es muy mala',
    'El profesor tiene mala voluntad',
    'La profesora llega tarde',
    'Las salas tienen mucho espacio',
    'Los aranceles son muy caros',
    'La institución tiene mucho prestigio',
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

  window.disc = new Disc(new Point(wWidth / 2, discSize / 2), discCenterSize, discSize);
  window.add = new Satellite(disc.position, satelliteSize, {'class': 'add'});

  add.satellite.click(function() {
    var sat = createCategorySatellite(add.position, add.size);
    disc.appendSatellite(sat);
  });

  $('.canvas').append(disc.disc);

  disc.appendSatellite(add);
  data.categories.forEach(function(category) {
    disc.appendSatellite(
      createCategorySatellite(disc.position, add.size, category));
  });

  next();
  $('#question-indicator').text('Pregunta 2');
  $('#training-next').click(next);
  $('#training-previous').click(previous);
}

$(document).ready(ready);
$(document).on('page:load', ready);;

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