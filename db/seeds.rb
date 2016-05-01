# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sm = SurveyModel.find_or_create_by(name: 'Encuesta Oficial Inacap', student_identifier: 3)

positive = Sentiment.find_or_create_by(name: "Positivo")
negative = Sentiment.find_or_create_by(name: "Negativo")
neutral = Sentiment.find_or_create_by(name: "Neutro")

Filter.find_or_create_by(survey_model_id: sm.id, name: 'Sede')
Filter.find_or_create_by(survey_model_id: sm.id, name: 'Jornada')
Filter.find_or_create_by(survey_model_id: sm.id, name: 'Institución')

q = Question.create_with(description: "¿Por qué razón o razones evalúas de esa forma tu experiencia general como alumno de Inacap?").
             find_or_create_by(survey_model_id: sm.id, label: "P2", index: 23)
Category.find_or_create_by(question_id: q.id, name: "Aprender Haciendo")
Category.find_or_create_by(question_id: q.id, name: "Eval. Académica")
Category.find_or_create_by(question_id: q.id, name: "Contenido Prog. Estudios")
Category.find_or_create_by(question_id: q.id, name: "Docentes")
Category.find_or_create_by(question_id: q.id, name: "Horarios")
Category.find_or_create_by(question_id: q.id, name: "Vida Universitaria")
Category.find_or_create_by(question_id: q.id, name: "Mov. Estudiantil")
Category.find_or_create_by(question_id: q.id, name: "Cercanía")
Category.find_or_create_by(question_id: q.id, name: "Autoridades")
Category.find_or_create_by(question_id: q.id, name: "Trámites Académicos")
Category.find_or_create_by(question_id: q.id, name: "Gestión Institucional")
Category.find_or_create_by(question_id: q.id, name: "Infraestructura")
Category.find_or_create_by(question_id: q.id, name: "Financiamiento")

q = Question.create_with(description: "¿Por qué razón evalúas con esa nota la satisfacción con tu Sede de Inacap?").
             find_or_create_by(survey_model_id: sm.id, label: "P4", index: 25)
Category.find_or_create_by(question_id: q.id, name: "Aprender Haciendo")
Category.find_or_create_by(question_id: q.id, name: "Eval. Académica")
Category.find_or_create_by(question_id: q.id, name: "Contenido Prog. Estudios")
Category.find_or_create_by(question_id: q.id, name: "Docentes")
Category.find_or_create_by(question_id: q.id, name: "Horarios")
Category.find_or_create_by(question_id: q.id, name: "Vida Universitaria")
Category.find_or_create_by(question_id: q.id, name: "Mov. Estudiantil")
Category.find_or_create_by(question_id: q.id, name: "Cercanía")
Category.find_or_create_by(question_id: q.id, name: "Autoridades")
Category.find_or_create_by(question_id: q.id, name: "Trámites Académicos")
Category.find_or_create_by(question_id: q.id, name: "Gestión Institucional")
Category.find_or_create_by(question_id: q.id, name: "Infraestructura")
Category.find_or_create_by(question_id: q.id, name: "Financiamiento")

q = Question.create_with(description: "¿Qué faltaría para que estuvieras completamente satisfecho con la conveniencia de estudiar en Inacap?").
             find_or_create_by(survey_model_id: sm.id, label: "P5.4", index: 29)
Category.find_or_create_by(question_id: q.id, name: "Aprender Haciendo")
Category.find_or_create_by(question_id: q.id, name: "Eval. Académica")
Category.find_or_create_by(question_id: q.id, name: "Contenido Prog. Estudios")
Category.find_or_create_by(question_id: q.id, name: "Docentes")
Category.find_or_create_by(question_id: q.id, name: "Horarios")
Category.find_or_create_by(question_id: q.id, name: "Vida Universitaria")
Category.find_or_create_by(question_id: q.id, name: "Mov. Estudiantil")
Category.find_or_create_by(question_id: q.id, name: "Cercanía")
Category.find_or_create_by(question_id: q.id, name: "Autoridades")
Category.find_or_create_by(question_id: q.id, name: "Trámites Académicos")
Category.find_or_create_by(question_id: q.id, name: "Gestión Institucional")
Category.find_or_create_by(question_id: q.id, name: "Infraestructura")
Category.find_or_create_by(question_id: q.id, name: "Financiamiento")
Category.find_or_create_by(question_id: q.id, name: "Empleabilidad")

q = Question.create_with(description: "¿Por qué razón o razones tienes ese nivel de satisfacción con el recibimiento que te dio Inacap en tu Sede?").
             find_or_create_by(survey_model_id: sm.id, label: "P7", index: 35)
Category.find_or_create_by(question_id: q.id, name: "Aprender Haciendo")
Category.find_or_create_by(question_id: q.id, name: "Eval. Académica")
Category.find_or_create_by(question_id: q.id, name: "Contenido Prog. Estudios")
Category.find_or_create_by(question_id: q.id, name: "Docentes")
Category.find_or_create_by(question_id: q.id, name: "Horarios")
Category.find_or_create_by(question_id: q.id, name: "Vida Universitaria")
Category.find_or_create_by(question_id: q.id, name: "Mov. Estudiantil")
Category.find_or_create_by(question_id: q.id, name: "Cercanía")
Category.find_or_create_by(question_id: q.id, name: "Autoridades")
Category.find_or_create_by(question_id: q.id, name: "Trámites Académicos")
Category.find_or_create_by(question_id: q.id, name: "Gestión Institucional")
Category.find_or_create_by(question_id: q.id, name: "Infraestructura")
Category.find_or_create_by(question_id: q.id, name: "Financiamiento")
Category.find_or_create_by(question_id: q.id, name: "Proceso Matrícula")
Category.find_or_create_by(question_id: q.id, name: "Toma de Ramos")
Category.find_or_create_by(question_id: q.id, name: "Actividades Bienvenida")
Category.find_or_create_by(question_id: q.id, name: "Apoyo")

q = Question.create_with(description: "¿Por qué razón o razones tienes ese nivel de satisfacción con el Vicerrector de tu Sede?").
             find_or_create_by(survey_model_id: sm.id, label: "P10", index: 41)
Category.find_or_create_by(question_id: q.id, name: "Disponibilidad")
Category.find_or_create_by(question_id: q.id, name: "Disposición")
Category.find_or_create_by(question_id: q.id, name: "Entrega de Info.")
Category.find_or_create_by(question_id: q.id, name: "Resolución de Problemas")
Category.find_or_create_by(question_id: q.id, name: "Plazos")

q = Question.create_with(description: "¿Por qué razón o razones tienes ese nivel de satisfacción con el desempeño del Director de Carrera?").
             find_or_create_by(survey_model_id: sm.id, label: "P19", index: 64)
Category.find_or_create_by(question_id: q.id, name: "Disponibilidad")
Category.find_or_create_by(question_id: q.id, name: "Disposición")
Category.find_or_create_by(question_id: q.id, name: "Entrega de Info.")
Category.find_or_create_by(question_id: q.id, name: "Resolución de Problemas")
Category.find_or_create_by(question_id: q.id, name: "Plazos")

q = Question.create_with(description: "¿Por qué razón no has participado de Actividades Extra-curriculares?").
             find_or_create_by(survey_model_id: sm.id, label: "P27", index: 91)
Category.find_or_create_by(question_id: q.id, name: "Carga Académica")
Category.find_or_create_by(question_id: q.id, name: "Incompatibilidad Horaria")
Category.find_or_create_by(question_id: q.id, name: "Desinterés")
Category.find_or_create_by(question_id: q.id, name: "Organización")
Category.find_or_create_by(question_id: q.id, name: "Oferta")
Category.find_or_create_by(question_id: q.id, name: "Distancia")
Category.find_or_create_by(question_id: q.id, name: "Infraestructura")

q = Question.create_with(description: "¿En cuál o cuáles actividades has participado?").
             find_or_create_by(survey_model_id: sm.id, label: "P28", index: 92)
Category.find_or_create_by(question_id: q.id, name: "Deportivo")
Category.find_or_create_by(question_id: q.id, name: "Cultural")
Category.find_or_create_by(question_id: q.id, name: "Artístico")
Category.find_or_create_by(question_id: q.id, name: "Recreacional")
Category.find_or_create_by(question_id: q.id, name: "Ciencia y Tecnología")
Category.find_or_create_by(question_id: q.id, name: "Seminarios")
Category.find_or_create_by(question_id: q.id, name: "Mercado Laboral")

q = Question.create_with(description: "¿Qué tipo de Actividades Extra-curriculares, te gustaría que se organizaran en tu sede de Inacap?").
             find_or_create_by(survey_model_id: sm.id, label: "P30", index: 98)
Category.find_or_create_by(question_id: q.id, name: "Deportivo")
Category.find_or_create_by(question_id: q.id, name: "Cultural")
Category.find_or_create_by(question_id: q.id, name: "Artístico")
Category.find_or_create_by(question_id: q.id, name: "Recreacional")
Category.find_or_create_by(question_id: q.id, name: "Ciencia y Tecnología")
Category.find_or_create_by(question_id: q.id, name: "Seminarios")
Category.find_or_create_by(question_id: q.id, name: "Mercado Laboral")
Category.find_or_create_by(question_id: q.id, name: "Horarios")

q = Question.create_with(description: "¿Qué faltaría para que estuvieras completamente satisfecho con la infraestructura de tu Sede?").
             find_or_create_by(survey_model_id: sm.id, label: "P34", index: 114)
Category.find_or_create_by(question_id: q.id, name: "Áreas Verdes")
Category.find_or_create_by(question_id: q.id, name: "Espacios Recreativos")
Category.find_or_create_by(question_id: q.id, name: "Bicicleta")
Category.find_or_create_by(question_id: q.id, name: "Casino o Cafetería")
Category.find_or_create_by(question_id: q.id, name: "Salas")
Category.find_or_create_by(question_id: q.id, name: "Limpieza")
Category.find_or_create_by(question_id: q.id, name: "Baños")
Category.find_or_create_by(question_id: q.id, name: "Biblioteca")
Category.find_or_create_by(question_id: q.id, name: "Internet")
Category.find_or_create_by(question_id: q.id, name: "Laboratorios")
Category.find_or_create_by(question_id: q.id, name: "Talleres")
Category.find_or_create_by(question_id: q.id, name: "Seguridad")
Category.find_or_create_by(question_id: q.id, name: "Emergencias")
Category.find_or_create_by(question_id: q.id, name: "Sombra")
Category.find_or_create_by(question_id: q.id, name: "Climatización")
Category.find_or_create_by(question_id: q.id, name: "Estacionamiento")

q = Question.create_with(description: "¿Por qué no has utilizado la Biblioteca de tu Sede durante este año?").
             find_or_create_by(survey_model_id: sm.id, label: "P38", index: 127)
Category.find_or_create_by(question_id: q.id, name: "Necesidad")
Category.find_or_create_by(question_id: q.id, name: "Capacidad")
Category.find_or_create_by(question_id: q.id, name: "Web")
Category.find_or_create_by(question_id: q.id, name: "Computadores")
Category.find_or_create_by(question_id: q.id, name: "Material")
Category.find_or_create_by(question_id: q.id, name: "Horarios")
Category.find_or_create_by(question_id: q.id, name: "Ambiente")
Category.find_or_create_by(question_id: q.id, name: "Atención")
Category.find_or_create_by(question_id: q.id, name: "Falta de Tiempo")

q = Question.create_with(description: "¿Podrías mencionar o describir brevemente cuál fue el principal problema que tuviste?").
             find_or_create_by(survey_model_id: sm.id, label: "P45", index: 149)
Category.find_or_create_by(question_id: q.id, name: "Horario")
Category.find_or_create_by(question_id: q.id, name: "Docencia")
Category.find_or_create_by(question_id: q.id, name: "Jefe de Carrera")
Category.find_or_create_by(question_id: q.id, name: "Salud")
Category.find_or_create_by(question_id: q.id, name: "Servicios")
Category.find_or_create_by(question_id: q.id, name: "Trámites")
Category.find_or_create_by(question_id: q.id, name: "Financiamiento")
Category.find_or_create_by(question_id: q.id, name: "Infraestructura")

q = Question.create_with(description: "¿Podrías mencionar a cuál o cuáles instancias de Inacap acudiste para plantear tu problema?").
             find_or_create_by(survey_model_id: sm.id, label: "P47", index: 151)
Category.find_or_create_by(question_id: q.id, name: "Autoridades Carrera")
Category.find_or_create_by(question_id: q.id, name: "Rectoría")
Category.find_or_create_by(question_id: q.id, name: "Docentes")
Category.find_or_create_by(question_id: q.id, name: "Asistente Social")
Category.find_or_create_by(question_id: q.id, name: "Finanzas")
Category.find_or_create_by(question_id: q.id, name: "DAE")
Category.find_or_create_by(question_id: q.id, name: "Web")
Category.find_or_create_by(question_id: q.id, name: "Call Center")

q = Question.create_with(description: "¿Por qué recomendarías Inacap?").
             find_or_create_by(survey_model_id: sm.id, label: "P53", index: 157)
Category.find_or_create_by(question_id: q.id, name: "Aprender Haciendo")
Category.find_or_create_by(question_id: q.id, name: "Evaluación Académica")
Category.find_or_create_by(question_id: q.id, name: "Contenido Prog. de Estudios")
Category.find_or_create_by(question_id: q.id, name: "Docentes")
Category.find_or_create_by(question_id: q.id, name: "Horarios")
Category.find_or_create_by(question_id: q.id, name: "Vida Universitaria")
Category.find_or_create_by(question_id: q.id, name: "Movimiento Estudiantil")
Category.find_or_create_by(question_id: q.id, name: "Cercanía")
Category.find_or_create_by(question_id: q.id, name: "Autoridades")
Category.find_or_create_by(question_id: q.id, name: "Trámites Académicos")
Category.find_or_create_by(question_id: q.id, name: "Gestión Institucional")
Category.find_or_create_by(question_id: q.id, name: "Infraestructura")
Category.find_or_create_by(question_id: q.id, name: "Financiamiento")

q = Question.create_with(description: "¿Cuáles serían las sugerencias más importantes que harías a tu sede de Inacap ?").
             find_or_create_by(survey_model_id: sm.id, label: "P55", index: 159)
Category.find_or_create_by(question_id: q.id, name: "Aprender Haciendo")
Category.find_or_create_by(question_id: q.id, name: "Evaluación Académica")
Category.find_or_create_by(question_id: q.id, name: "Contenido Prog. de Estudios")
Category.find_or_create_by(question_id: q.id, name: "Docentes")
Category.find_or_create_by(question_id: q.id, name: "Horarios")
Category.find_or_create_by(question_id: q.id, name: "Vida Universitaria")
Category.find_or_create_by(question_id: q.id, name: "Movimiento Estudiantil")
Category.find_or_create_by(question_id: q.id, name: "Cercanía")
Category.find_or_create_by(question_id: q.id, name: "Autoridades")
Category.find_or_create_by(question_id: q.id, name: "Trámites Académicos")
Category.find_or_create_by(question_id: q.id, name: "Gestión Institucional")
Category.find_or_create_by(question_id: q.id, name: "Infraestructura")
Category.find_or_create_by(question_id: q.id, name: "Financiamiento")


cq1 = CloseEndedQuestion.create_with(description: '¿Qué tan satisfecho estás con tu experiencia general como alumno de Inacap?').
                        find_or_create_by(survey_model_id: sm.id, label: "P1", index: 1)

cq3 = CloseEndedQuestion.create_with(description: '¿Qué tan satisfecho estás con tu experiencia como alumno de tu Sede de Inacap?').
                        find_or_create_by(survey_model_id: sm.id, label: "P3", index: 2)

cq5_3 = CloseEndedQuestion.create_with(description: '¿Cuál es tu nivel de satisfacción con la conveniencia de estudiar en Inacap?').
                        find_or_create_by(survey_model_id: sm.id, label: "P5.3", index: 3)

cq6_5 = CloseEndedQuestion.create_with(description: '¿Qué tan satisfecho estás con la experiencia inicial que tuviste en tu Sede de Inacap?').
                        find_or_create_by(survey_model_id: sm.id, label: "P6.5", index: 4)

cq9_4 = CloseEndedQuestion.create_with(description: '¿Qué tan satisfecho estás con el Vicerrector de tu Sede?').
                        find_or_create_by(survey_model_id: sm.id, label: "P9.4", index: 5)

cq18_5 = CloseEndedQuestion.create_with(description: '¿Qué tan satisfecho estás con el Director de tu Carrera?').
                        find_or_create_by(survey_model_id: sm.id, label: "P18.5", index: 6)

cq29_5 = CloseEndedQuestion.create_with(description: '¿Qué tan satisfecho estás con las Actividades Extra-curriculares ofrecidas en Inacap?').
                        find_or_create_by(survey_model_id: sm.id, label: "P29.5", index: 7)

cq33_10 = CloseEndedQuestion.create_with(description: '¿Qué tan satisfecho estás con la Infraestructura de tu Sede?').
                        find_or_create_by(survey_model_id: sm.id, label: "P33.10", index: 8)

cq39_7 = CloseEndedQuestion.create_with(description: '¿Qué tan satisfecho estás con el servicio de la Biblioteca de tu Sede?').
                        find_or_create_by(survey_model_id: sm.id, label: "P39.7", index: 9)

cq50_1 = CloseEndedQuestion.create_with(description: 'Atención brindada por Inacap frente a tu problema').
                        find_or_create_by(survey_model_id: sm.id, label: "P50.1", index: 10)

cq51 = CloseEndedQuestion.create_with(description: '¿Qué tan satisfecho estás con tu experiencia como alumno de tu Sede de Inacap?').
                        find_or_create_by(survey_model_id: sm.id, label: "P51", index: 11)

cq52 = CloseEndedQuestion.create_with(description: '¿Qué tan dispuesto estarías a recomendar a otras personas estudiar en Inacap').
                        find_or_create_by(survey_model_id: sm.id, label: "P52", index: 12)

QuestionRelationship.create_with(name: "Sub-Dimensión: Satisfacción Inicial Inacap").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P2").id,
                        close_ended_question_id: cq1.id)

QuestionRelationship.create_with(name: "Sub-Dimensión: Satisfacción Inicial Sede").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P4").id,
                        close_ended_question_id: cq3.id)

QuestionRelationship.create_with(name: "Dimensión: Conveniencia").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P5.4").id,
                        close_ended_question_id: cq5_3.id)

QuestionRelationship.create_with(name: "Dimensión: Ciclo Inicial en Inacap").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P7").id,
                        close_ended_question_id: cq6_5.id)

QuestionRelationship.create_with(name: "Sub-Dimensión: Vicerrector de Sede").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P10").id,
                        close_ended_question_id: cq9_4.id)

QuestionRelationship.create_with(name: "Sub-Dimensión: Director de Carrera").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P19").id,
                        close_ended_question_id: cq18_5.id)

QuestionRelationship.create_with(name: "Dimensión: Actividades Extra-Curriculares").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P27").id,
                        close_ended_question_id: cq29_5.id)

QuestionRelationship.create_with(name: "Dimensión: Actividades Extra-Curriculares").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P28").id,
                        close_ended_question_id: cq29_5.id)

QuestionRelationship.create_with(name: "Dimensión: Actividades Extra-Curriculares").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P30").id,
                        close_ended_question_id: cq29_5.id)

QuestionRelationship.create_with(name: "Dimensión: Infraestructura").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P34").id,
                        close_ended_question_id: cq33_10.id)

QuestionRelationship.create_with(name: "Dimensión: Biblioteca").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P38").id,
                        close_ended_question_id: cq39_7.id)

QuestionRelationship.create_with(name: "Dimensión: Resolución de Problemas").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P47").id,
                        close_ended_question_id: cq50_1.id)

QuestionRelationship.create_with(name: "Dimensión: Recomendación").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P53").id,
                        close_ended_question_id: cq52.id)

QuestionRelationship.create_with(name: "Sub-Dimensión: Satisfacción Final").
                     find_or_create_by(
                        question_id: sm.questions.find_by_label("P55").id,
                        close_ended_question_id: cq51.id)
