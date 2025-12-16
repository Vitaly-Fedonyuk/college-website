# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Creating admin user..."
User.find_or_create_by!(email: 'admin@college.edu') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
end
puts "Admin user created: admin@college.edu / password123"

puts "Creating sample news..."

# Create sample news
news_items = [
  {
    title: "Розпочато новий навчальний рік",
    content: "Сьогодні в нашому коледжі відбулася урочиста лінійка з нагоди початку нового навчального року. Ми вітаємо всіх студентів та викладачів! Бажаємо успіхів у навчанні та нових досягнень.",
    published_at: 2.days.ago
  },
  {
    title: "День відкритих дверей",
    content: "Запрошуємо всіх абітурієнтів та їхніх батьків на День відкритих дверей, який відбудеться наступної суботи. Ви зможете відвідати навчальні аудиторії, зустрітися з викладачами та дізнатися більше про наші спеціальності.",
    published_at: 5.days.ago
  },
  {
    title: "Наші студенти перемогли в обласному конкурсі",
    content: "Вітаємо наших студентів з перемогою в обласному конкурсі професійної майстерності! Це чудовий результат, який показує високий рівень підготовки в нашому коледжі.",
    published_at: 10.days.ago
  },
  {
    title: "Оновлення матеріально-технічної бази",
    content: "У нашому коледжі завершено оновлення комп'ютерних класів. Нове обладнання дозволить студентам здобувати знання на найсучаснішій техніці.",
    published_at: 15.days.ago
  },
  {
    title: "Спортивні досягнення коледжу",
    content: "Команда нашого коледжу зайняла призові місця на міжобласних спортивних змаганнях. Вітаємо наших спортсменів з чудовими результатами!",
    published_at: 20.days.ago
  }
]

news_items.each do |news_data|
  News.find_or_create_by!(title: news_data[:title]) do |news|
    news.content = news_data[:content]
    news.published_at = news_data[:published_at]
  end
end

puts "Created #{News.count} news items"

puts "Creating sample documents..."

# Create sample documents
documents = [
  {
    name: "Правила внутрішнього розпорядку",
    description: "Документ містить правила внутрішнього розпорядку коледжу"
  },
  {
    name: "Навчальний план",
    description: "Навчальний план на поточний навчальний рік"
  }
]

documents.each do |doc_data|
  Document.find_or_create_by!(name: doc_data[:name]) do |doc|
    doc.description = doc_data[:description]
  end
end

puts "Created #{Document.count} documents"
puts "Seeding completed!"
