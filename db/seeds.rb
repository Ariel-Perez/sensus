# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sm = SurveyModel.create(name: 'Encuesta Oficial Inacap', student_identifier: 3)

questions = Question.create([
  {survey_model_id: sm.id, label: "P2", index: 23, description: "¿Por qué razón o razones evalúas de esa forma tu experiencia general como alumno de INACAP?"},
  {survey_model_id: sm.id, label: "P4", index: 25, description: "¿Por qué razón evalúas con esa nota la satisfacción con tu SEDE de INACAP?"},
  {survey_model_id: sm.id, label: "P5.4", index: 29, description: "¿Qué faltaría para que estuvieras completamente satisfecho con la conveniencia de estudiar en Inacap?"},
  {survey_model_id: sm.id, label: "P7", index: 35, description: "¿Por qué razón o razones tienes ese nivel de satisfacción con el recibimiento que te dio INACAP en tu Sede?"},
  {survey_model_id: sm.id, label: "P10", index: 41, description: "¿Por qué razón o razones tienes ese nivel de satisfacción con el Vicerrector de tu Sede?"},
  {survey_model_id: sm.id, label: "P19", index: 64, description: "¿Por qué razón o razones tienes ese nivel de satisfacción con el desempeño del Director de Carrera?"},
  {survey_model_id: sm.id, label: "P27", index: 91, description: "¿Por qué razón no has participado de Actividades Extra-curriculares?"},
  {survey_model_id: sm.id, label: "P28", index: 92, description: "¿En cuál o cuáles actividades has participado?"},
  {survey_model_id: sm.id, label: "P30", index: 98, description: "¿Qué tipo de Actividades Extra-curriculares, te gustaría que se organizaran en tu sede de INACAP?"},
  {survey_model_id: sm.id, label: "P34", index: 114, description: "¿Qué faltaría para que estuvieras completamente satisfecho con la infraestructura de tu Sede?"},
  {survey_model_id: sm.id, label: "P38", index: 127, description: "¿Por qué no has utilizado la Biblioteca de tu Sede durante este año?"},
  {survey_model_id: sm.id, label: "P45", index: 149, description: "¿Podrías mencionar o describir brevemente cuál fue el principal problema que tuviste?"},
  {survey_model_id: sm.id, label: "P47", index: 151, description: "¿Podrías mencionar a cuál o cuáles instancias de INACAP acudiste para plantear tu problema?"},
  {survey_model_id: sm.id, label: "P53", index: 157, description: "¿Por qué?"},
  {survey_model_id: sm.id, label: "P55", index: 159, description: "¿Cuáles serían las sugerencias más importantes que harías a tu sede de INACAP ?"}
])
