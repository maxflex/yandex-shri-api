namespace :db do
  desc 'populate the database with initial data'

  lecture_topics = {
    frontend: [
      'Адаптивная вёрстка',
      'Работа с сенсорным пользовательским вводом',
      'Мультимедиа: возможности браузера',
      'Нативные приложения на веб-технологиях',
      'Клиентская оптимизация: базовые знания и лучшие практики',
      'Клиентская оптимизация: мобильные устройства и инструменты',
      'Инфраструктура веб-проектов',
      'Инструменты разработки мобильного фронтенда',
    ],
    mobdev: [
      'Java Blitz (Часть 1)',
      'Git & Workflow',
      'Java Blitz (Часть 2)',
      'MyFirstApp (Часть 1)',
      'MyFirstApp (Часть 2)',
      'ViewGroup',
      'Background',
      'RecyclerView',
      'Service & Broadcasts',
      'Drawing',
      'Content provider',
      'Debugging & Polishing'
    ],
    design: [
      'Идея, исследование, концепт (Часть 1)',
      'Идея, исследование, концепт (Часть 2)',
      'Особенности проектирования мобильных интерфейсов',
      'Продукт и платформа',
      'Природа операционных систем',
      'Прототипирование как процесс',
      'Инструмент под задачи',
      'Анимации',
      'Развите продукта',
      'Исследование интерфейсов',
      'Работа в команде'
    ]
  }

  videos = ['2KsuNVsS-xc', 'pGY5pEe0Q1U', '2O_CShWrJDk', '9HYHxky799o', 'yUHlrabtEaU', 'RbXWc36KYTg', 'XxxkGZs_GWA', '7iEkcZrVU_s', 'jeg-RpXjdZ4']

  time_ranges = [
    ['19:00', '21:00'],
    ['19:00', '21:30'],
    ['20:00', '22:00'],
  ]

  auditorium_names = ['Синий кит', 'Красное дерево', 'Технопарк', 'Большой зал', 'Пиксели', 'Нео холл']

  task populate: :environment do
    # clear tables and reset indexes
    ['lectures_schools', 'lectures', 'speakers', 'auditoria', 'materials'].each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE #{table} RESTART IDENTITY CASCADE")
    end
    20.times do
      Speaker.create({
        name: Faker::Name.male_first_name + ' ' + Faker::Name.male_last_name,
        workplace: 'Яндекс',
        description: Faker::Name.title,
        photo_url: Faker::Avatar.image
      })
    end
    6.times do |index|
      Auditorium.create({
        name: auditorium_names[index - 1],
        capacity: Faker::Number.between(50, 150),
        address: Faker::Address.street_address
      })
    end
    lecture_topics.each do |url, topics|
      date = rand(1..10).days.ago
      lecture = nil
      school = School.where('url=?', url).first
      topics.each do |topic|
        time = time_ranges.sample
        lecture = Lecture.create({
          speaker_id: Speaker.order("random()").first.id,
          auditorium_id: Auditorium.order("random()").first.id,
          topic: topic,
          date: date,
          time_start: time[0],
          time_end: time[1],
          students_count: Faker::Number.between(50, 150)
        })

        # if lecture in past dates
        lecture.create_material({
          video: videos.sample,
          link: 'http://download.yandex.ru/company/experience/rit2008/highload_lapan.pdf'
        }) if date < Date.today

        # adding a school to a lecture
        lecture.schools << school

        # maybe add other schools to a lecture
        lecture.schools << School.where('id <> ?', school.id).all if rand(1..10) > 8

        date = date + rand(1..3).days
      end
    end
  end
end
