results = []
sum = 0
qs = Question.where(survey_model_id: 1)
qs.each do |q|
  cat_ids = q.categories.pluck(:id)
  answers = AnswerCategory.where(category_id: cat_ids).group(:answer_id).count()
  count = answers.count
  results.push([q.label, count])
  sum += count
end

results.each do |r|
  puts "#{r[0]}, #{r[1]}"
end
puts sum