ActiveRecord::Base.connection.execute("TRUNCATE schools RESTART IDENTITY")

School.create([
  {
    name: 'Школа разработки интерфейсов',
    url: 'frontend',
    students_count: 500
  },
  {
    name: 'Школа мобильной разработки',
    url: 'mobdev',
    students_count: 750
  },
  {
    name: 'Школа мобильного дизайна',
    url: 'design',
    students_count: 400
  },
])
