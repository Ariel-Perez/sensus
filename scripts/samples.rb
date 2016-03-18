n = 50
results = {}
qs = Question.where(survey_model_id: 1)
qs.each do |q|
  cat_ids = q.categories.pluck(:id)
  answer_ids = AnswerCategory.where(category_id: cat_ids).uniq.pluck(:answer_id)

  samples = []
  m = [n, answer_ids.length].min
  (0..m-1).each do |i|
    answer = Answer.find(answer_ids[i])
    samples.push({"answer": answer.text, "categories": answer.categories.pluck(:name)})
  end
  results[q.label] = samples
end

qs.each do |q|
  puts q.label
  n = results[q.label].length
  (0..n-1).each do |i|
    r = results[q.label][i]
    puts "'#{r[:answer]}', #{r[:categories].to_s}"
  end
  puts ''
end