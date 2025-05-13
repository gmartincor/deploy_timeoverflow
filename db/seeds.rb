# Original organizations with location data - adding update logic
org1 = Organization.find_or_create_by(name: "Banco de Tiempo Local")
org1.update(
  address: "Carrer de Bailèn, 123",
  neighborhood: "Eixample",
  city: "Barcelona"
)

org2 = Organization.find_or_create_by(name: "El otro Banco de Tiempo :)")
org2.update(
  address: "Calle Gran Vía, 45",
  neighborhood: "Centro",
  city: "Madrid"
)

# Original users
User.find_or_create_by(email: "admin@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Manuel Administrador"
  user.date_of_birth = Date.parse("1982-10-12")
  user.phone = "652212383"
  user.alt_phone = "656312313"
  user.description = <<-EOF
  Soy Manuel, tu gestor del Banco de Tiempo estoy aqui para facilitarte la vida, cualquier duda, contacta conmigo"
  EOF
end

User.find_or_create_by(email: "user@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Josep Maria Calastruc"
  user.date_of_birth = Date.parse("1962-01-30")
  user.phone = "712554871"
  user.alt_phone = "932101846"
  user.description = <<-EOF
  Hola nanus, soc supercatala! Viu i deixa viure
  EOF
end

User.find_or_create_by(email: "anna@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Anna Laparra"
  user.date_of_birth = Date.parse("1962-02-05")
  user.phone = "610568452"
  user.description = <<-EOF
  Soy puntual, por favor LLEGA A LA HORA, con amor te lo digo
  EOF
end

User.find_or_create_by(email: "julia@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Julia Alonso"
  user.date_of_birth = Date.parse("1992-06-10")
  user.phone = "682456987"
  user.alt_phone = "934574538"
  user.description = <<-EOF
  Soc molt fort i el meu nom es musculator,...
  EOF
end

User.find_or_create_by(email: "admin2@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Antonia Maria Sala"
  user.date_of_birth = Date.parse("1962-02-05")
  user.phone = "610568452"
  user.description = <<-EOF
  Soy puntual, por favor LLEGA A LA HORA, con amor te lo digo
  EOF
end

User.find_or_create_by(email: "user2@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Esperanza Andana"
  user.date_of_birth = Date.parse("1992-06-10")
  user.phone = "682456987"
  user.alt_phone = "934574538"
  user.description = <<-EOF
  Soc molt fort i el meu nom es musculator,...
  EOF
end

# Original memberships
User.find_by(email: "admin@timeoverflow.org").members.
  find_or_create_by(organization_id: 1) do |member|
  member.manager = true
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "user@timeoverflow.org").members.
  find_or_create_by(organization_id: 1) do |member|
  member.manager = false
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "anna@timeoverflow.org").members.
  find_or_create_by(organization_id: 1) do |member|
  member.manager = true
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "julia@timeoverflow.org").members.
  find_or_create_by(organization_id: 1) do |member|
  member.manager = true
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "admin2@timeoverflow.org").members.
  find_or_create_by(organization_id: 1) do |member|
  member.manager = true
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "admin2@timeoverflow.org").members.
  find_or_create_by(organization_id: 2) do |member|
  member.manager = true
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "user2@timeoverflow.org").members.
  find_or_create_by(organization_id: 2) do |member|
  member.manager = false
  member.entry_date = DateTime.now.utc
end

# New organizations with location data
org3 = Organization.find_or_create_by(name: "Banco del tiempo 3")
org3.update(
  address: "Ronda de Poniente, 2",
  neighborhood: "",
  city: "Motril"
)

org4 = Organization.find_or_create_by(name: "Banco del tiempo 4")
org4.update(
  address: "Calle Monforte, 2",
  neighborhood: "",
  city: "Lugo"
)

org5 = Organization.find_or_create_by(name: "Banco del tiempo 5")
org5.update(
  address: "Camino de Ronda, 60",
  neighborhood: "",
  city: "Granada"
)

valencia_org = Organization.find_or_create_by(name: "Banco de Tiempo Valencia")
valencia_org.update(
  address: "Calle Colón, 34",
  neighborhood: "Ciutat Vella",
  city: "Valencia"
)

sevilla_org = Organization.find_or_create_by(name: "Banco de Tiempo Sevilla")
sevilla_org.update(
  address: "Calle San Jacinto, 89",
  neighborhood: " ",
  city: "Sevilla"
)

bilbao_org = Organization.find_or_create_by(name: "Banco de Tiempo Bilbao")
bilbao_org.update(
  address: "Gran Vía Don Diego López de Haro, 12",
  neighborhood: "Abando",
  city: "Bilbao"
)

zaragoza_org = Organization.find_or_create_by(name: "Banco de Tiempo Zaragoza")
zaragoza_org.update(
  address: "Paseo Independencia, 23",
  neighborhood: "Centro",
  city: "Zaragoza"
)

malaga_org = Organization.find_or_create_by(name: "Banco de Tiempo Málaga")
malaga_org.update(
  address: "Calle Marqués de Larios, 5",
  neighborhood: "Centro Histórico",
  city: "Málaga"
)

# Admin3
User.find_or_create_by(email: "admin3@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Carlos Administrador"
  user.date_of_birth = Date.parse("1985-05-15")
  user.phone = "652789123"
  user.alt_phone = "932458791"
  user.description = <<-EOF
  Soy Carlos, administrador del Banco del tiempo 3. Estoy para ayudar en lo que necesites.
  EOF
end

# User3
User.find_or_create_by(email: "user3@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Marta García"
  user.date_of_birth = Date.parse("1978-08-21")
  user.phone = "645871236"
  user.alt_phone = "934587123"
  user.description = <<-EOF
  Hola a todos! Me encanta intercambiar servicios y conocer gente nueva.
  EOF
end

# Admin4
User.find_or_create_by(email: "admin4@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Elena Fernández"
  user.date_of_birth = Date.parse("1979-11-03")
  user.phone = "612345789"
  user.alt_phone = "932147856"
  user.description = <<-EOF
  Administradora del Banco del tiempo 4. Dispuesta a ayudar siempre.
  EOF
end

# User4
User.find_or_create_by(email: "user4@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Pablo Rodríguez"
  user.date_of_birth = Date.parse("1990-04-17")
  user.phone = "658974123"
  user.alt_phone = "931248756"
  user.description = <<-EOF
  Programador y aficionado a la cocina vegetariana. Busco intercambios relacionados con tecnología.
  EOF
end

#userGuille
User.find_or_create_by(email: "guillermomc007@gmail.com") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Guillermo Martín"
  user.date_of_birth = Date.parse("1990-04-17")
  user.phone = "658974123"
  user.alt_phone = "931248756"
  user.description = <<-EOF
  Programador y aficionado a la cocina vegetariana. Busco intercambios relacionados con tecnología.
  EOF
end

# Admin5
User.find_or_create_by(email: "admin5@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Laura Sánchez"
  user.date_of_birth = Date.parse("1983-09-25")
  user.phone = "675849231"
  user.alt_phone = "934512687"
  user.description = <<-EOF
  Administradora del Banco del tiempo 5 enfocada en construir una comunidad activa y participativa.
  EOF
end

# User5
User.find_or_create_by(email: "user5@timeoverflow.org") do |user|
  user.terms_accepted_at = DateTime.now.utc
  user.confirmed_at = DateTime.now.utc
  user.password = "1234test"
  user.password_confirmation = "1234test"
  user.username = "Miguel Torres"
  user.date_of_birth = Date.parse("1988-12-12")
  user.phone = "689521473"
  user.alt_phone = "935478126"
  user.description = <<-EOF
  Apasionado de la jardinería y las manualidades. Dispuesto a compartir conocimientos.
  EOF
end

# New memberships
# Get organization references with the new names
org3 = Organization.find_by(name: "Banco del tiempo 3")
org4 = Organization.find_by(name: "Banco del tiempo 4")
org5 = Organization.find_by(name: "Banco del tiempo 5")

# Add memberships for admin3/user3 to organization 3
User.find_by(email: "admin3@timeoverflow.org").members.
  find_or_create_by(organization: org3) do |member|
  member.manager = true
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "user3@timeoverflow.org").members.
  find_or_create_by(organization: org3) do |member|
  member.manager = false
  member.entry_date = DateTime.now.utc
end

# Add memberships for admin4/user4 to organization 4
User.find_by(email: "admin4@timeoverflow.org").members.
  find_or_create_by(organization: org4) do |member|
  member.manager = true
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "user4@timeoverflow.org").members.
  find_or_create_by(organization: org4) do |member|
  member.manager = false
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "guillermomc007@gmail.com").members.
  find_or_create_by(organization: org4) do |member|
  member.manager = false
  member.entry_date = DateTime.now.utc
end


# Add memberships for admin5/user5 to organization 5
User.find_by(email: "admin5@timeoverflow.org").members.
  find_or_create_by(organization: org5) do |member|
  member.manager = true
  member.entry_date = DateTime.now.utc
end

User.find_by(email: "user5@timeoverflow.org").members.
  find_or_create_by(organization: org5) do |member|
  member.manager = false
  member.entry_date = DateTime.now.utc
end

# Categories
unless Category.exists?
  Category.connection.execute "ALTER SEQUENCE categories_id_seq RESTART;"
  [
    "Acompañamiento", "Salud", "Tareas domésticas", "Tareas administrativas", "Estética", "Clases",
    "Ocio", "Asesoramiento", "Otros", "Préstamo de herramientas, material, libros, ...", "Tareas domésticas"
  ].each do |name|
    unless Category.with_name_translation(name).exists?
      Category.create { |c| c.name = name }
    end
  end
end

# Offers
Offer.find_or_create_by(title: "Ruby on Rails nivel principiante") do |post|
  post.description = <<-EOF
  Te enseño a trastear un poco sin cuidar el codigo, pero con mucho amor.
  Aprenderas a ser un coder de verdad http://rubyonrails.org/
  EOF
  post.category_id = 5
  post.user_id = 1
  post.tags = ["Rails", "Ruby", "programación"]
  post.organization_id = 1
end

Offer.find_or_create_by(title: "Cocina low cost") do |post|
  post.description = <<-EOF
  Si **no sabes que puedes comer** y no quieres gastar mucho dinero te enseño como hacer una sopa de plantas silvestres encontradas entre las grietas del asfalto
  EOF
  post.category_id = 7
  post.user_id = 1
  post.tags = ["Cocinar", "Cocina"]
  post.organization_id = 1
end

Offer.find_or_create_by(title: "Yoga para principiantes") do |post|
  post.description = <<-EOF
  Comparteixo les tècniques que he après i he practicat de respiració i meditació (una és inherent a l´altra, l´altra és inherent a l´una).
  En cada sessió: minuts de consciencia postural, cant de mantres, *breu escalfament** (movilització de l´articulacions i la columna vertebral) i una sèrie de PRANAYAMA (respiració) / MEDITACIÓ. Sessions de 1h aprox. *CAPACITACIÓ INTERNACIONAL DE MESTRES DE KUNDALINI IOGA, NIVELL I d'acord Yogi Bhajan. per la "KRI" (KUNDALINI RESEARCH INSTITUT)
  EOF
  post.category_id = 5
  post.user_id = 2
  post.tags = ["Yoga", "Estiramientos", "Respiración", "Meditación"]
  post.organization_id = 1
end

Offer.find_or_create_by(title: "English conversation") do |post|
  post.description = <<-EOF
  Our specially designed courses are for adults looking to improve their proficiency in English. Whether you want to improve your overall communication, take an English exam, or simply want to develop your spoken English skills, we have the right course for you. All successful students will receive a British Council certificate at the end of the course.
  EOF
  post.category_id = 5
  post.user_id = 2
  post.tags = ["Inglés", "English", "Conversación"]
  post.organization_id = 1
end

Offer.find_or_create_by(title: "Te enseño a escribir con Markdown") do |post|
  post.description = <<-EOF
  An h1 header
  ============

  ![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)


  Paragraphs are separated by a blank line.

  2nd paragraph. *Italic*, **bold**, and `monospace`. Itemized lists
  look like:

    * this one
    * that one
    * the other one

  Note that --- not considering the asterisk --- the actual text
  content starts at 4-columns in.

  http://www.google.com
  EOF
  post.category_id = 5
  post.user_id = 1
  post.tags = ["Markdown", "programación"]
  post.organization_id = 1
end

Offer.find_or_create_by(title: "Pequeñas reparaciones de casa") do |post|
  post.description = <<-EOF
  Llamame y miramos que necesitas, si veo que puedo ayudarte nos ponemos a ello
  EOF
  post.category_id = 3
  post.user_id = 3
  post.tags = ["casa", "manitas"]
  post.organization_id = 1
end

# Obtener IDs de usuarios
admin3_id = User.find_by(email: "admin3@timeoverflow.org").id
user3_id = User.find_by(email: "user3@timeoverflow.org").id
admin4_id = User.find_by(email: "admin4@timeoverflow.org").id
user4_id = User.find_by(email: "user4@timeoverflow.org").id
guille_id = User.find_by(email: "guillermomc007@gmail.com").id
admin5_id = User.find_by(email: "admin5@timeoverflow.org").id
user5_id = User.find_by(email: "user5@timeoverflow.org").id

# Ofertas para admin3 (Banco 3)
Offer.find_or_create_by(title: "Asesoramiento legal básico") do |post|
  post.description = <<-EOF
  Ofrezco orientación legal básica en temas de consumo, laborales y administrativos. 
  No sustituye el asesoramiento de un abogado pero puedo ayudarte a entender mejor 
  tus derechos y opciones antes de acudir a un profesional.
  EOF
  post.category_id = 8 # Asesoramiento
  post.user_id = admin3_id
  post.tags = ["Legal", "Derechos", "Consumo"]
  post.organization_id = org3.id
end

Offer.find_or_create_by(title: "Clases de guitarra española") do |post|
  post.description = <<-EOF
  Imparto clases de guitarra española para principiantes y nivel intermedio. 
  Aprenderás técnicas básicas, acordes principales y a tocar tus primeras canciones.
  Clases individuales o en pequeños grupos de máximo 3 personas.
  EOF
  post.category_id = 6 # Clases
  post.user_id = admin3_id
  post.tags = ["Música", "Guitarra", "Aprendizaje"]
  post.organization_id = org3.id
end

Offer.find_or_create_by(title: "Acompañamiento a personas mayores") do |post|
  post.description = <<-EOF
  Ofrezco compañía a personas mayores: paseos, lectura, conversación o simplemente estar presente. 
  La soledad puede ser difícil y a veces solo hace falta alguien con quien hablar 
  o compartir un rato agradable.
  EOF
  post.category_id = 1 # Acompañamiento
  post.user_id = admin3_id
  post.tags = ["Mayores", "Compañía", "Paseos"]
  post.organization_id = org3.id
end

# Ofertas para user3 (Banco 3)
Offer.find_or_create_by(title: "Preparación de comidas saludables") do |post|
  post.description = <<-EOF
  Cocino lotes de comidas saludables que puedes congelar para toda la semana. 
  Especialidad en dietas equilibradas, bajas en calorías pero sabrosas. 
  También puedo enseñarte recetas fáciles para que aprendas a hacerlo tú mismo/a.
  EOF
  post.category_id = 3 # Tareas domésticas
  post.user_id = user3_id
  post.tags = ["Cocina", "Saludable", "Batch cooking"]
  post.organization_id = org3.id
end

Offer.find_or_create_by(title: "Masajes descontracturantes") do |post|
  post.description = <<-EOF
  Realizo masajes para aliviar tensiones musculares, especialmente en espalda, 
  hombros y cuello. Tengo formación en masaje terapéutico y experiencia 
  tratando problemas comunes derivados del estrés y malas posturas.
  EOF
  post.category_id = 2 # Salud
  post.user_id = user3_id
  post.tags = ["Masaje", "Relajación", "Terapia"]
  post.organization_id = org3.id
end

Offer.find_or_create_by(title: "Préstamo de herramientas de jardinería") do |post|
  post.description = <<-EOF
  Dispongo de un set completo de herramientas de jardinería que presto: 
  tijeras de podar, palas pequeñas, rastrillo, guantes y más. 
  También puedo darte consejos sobre cuidado de plantas si lo necesitas.
  EOF
  post.category_id = 10 # Préstamo de herramientas
  post.user_id = user3_id
  post.tags = ["Jardinería", "Herramientas", "Plantas"]
  post.organization_id = org3.id
end

# Ofertas para admin4 (Banco 4)
Offer.find_or_create_by(title: "Ayuda con trámites administrativos") do |post|
  post.description = <<-EOF
  Te ayudo con formularios, solicitudes y trámites online con la administración pública.
  Tengo experiencia en gestiones con hacienda, seguridad social, ayuntamiento, etc.
  También puedo explicarte cómo hacerlos para futuras ocasiones.
  EOF
  post.category_id = 4 # Tareas administrativas
  post.user_id = admin4_id
  post.tags = ["Trámites", "Burocracia", "Ayuda"]
  post.organization_id = org4.id
end

Offer.find_or_create_by(title: "Organización de eventos y celebraciones") do |post|
  post.description = <<-EOF
  Planificación de pequeños eventos: cumpleaños, reuniones, celebraciones. 
  Me encargo de la organización, ideas para decoración, actividades y todo 
  lo necesario para que disfrutes sin preocupaciones de tu evento.
  EOF
  post.category_id = 7 # Ocio
  post.user_id = admin4_id
  post.tags = ["Eventos", "Celebraciones", "Organización"]
  post.organization_id = org4.id
end

Offer.find_or_create_by(title: "Cortes de pelo básicos") do |post|
  post.description = <<-EOF
  Realizo cortes de pelo sencillos para todas las edades. No soy profesional pero
  tengo experiencia cortando el pelo a familiares y amigos. Ideal para quien 
  busca un mantenimiento simple de su peinado sin gastar en peluquería.
  EOF
  post.category_id = 5 # Estética
  post.user_id = admin4_id
  post.tags = ["Peluquería", "Corte", "Pelo"]
  post.organization_id = org4.id
end

# Ofertas para user4 (Banco 4)
Offer.find_or_create_by(title: "Reparación de ordenadores y móviles") do |post|
  post.description = <<-EOF
  Soluciono problemas comunes de ordenadores (Windows/Mac) y smartphones.
  Elimino virus, optimizo el rendimiento, recupero datos borrados, instalo programas
  y hago pequeñas reparaciones. ¡No tires tu dispositivo antes de consultarme!
  EOF
  post.category_id = 9 # Otros
  post.user_id = user4_id
  post.tags = ["Informática", "Reparación", "Tecnología"]
  post.organization_id = org4.id
end

Offer.find_or_create_by(title: "Clases de programación para principiantes") do |post|
  post.description = <<-EOF
  Imparto clases para iniciarse en la programación desde cero. Aprenderás 
  conceptos básicos y a crear tus primeras aplicaciones sencillas. Adaptado a 
  cada persona, avanzando a tu ritmo y orientado a tus intereses particulares.
  EOF
  post.category_id = 6 # Clases
  post.user_id = user4_id
  post.tags = ["Programación", "Informática", "Aprendizaje"]
  post.organization_id = org4.id
end

Offer.find_or_create_by(title: "Paseo y cuidado de mascotas") do |post|
  post.description = <<-EOF
  Me ofrezco para pasear a tu perro o cuidar de tus mascotas durante ausencias cortas.
  Tengo experiencia con perros, gatos y animales pequeños. Responsable y cariñoso
  con los animales, asegurando que reciban los cuidados y atención que necesitan.
  EOF
  post.category_id = 1 # Acompañamiento
  post.user_id = user4_id
  post.tags = ["Mascotas", "Animales", "Cuidados"]
  post.organization_id = org4.id
end

# Ofertas para Guillermo (Banco 4)
Offer.find_or_create_by(title: "Clases de desarrollo web frontend") do |post|
  post.description = <<-EOF
  Ofrezco clases personalizadas de HTML, CSS y JavaScript para principiantes
  que quieran aprender desarrollo web frontend. Aprenderás a crear sitios
  web responsivos y atractivos desde cero. Incluyo material práctico y
  ejercicios para consolidar conocimientos.
  EOF
  post.category_id = 6 # Clases
  post.user_id = guille_id
  post.tags = ["Desarrollo web", "Frontend", "Programación"]
  post.organization_id = org4.id
end

Offer.find_or_create_by(title: "Asesoramiento en nutrición vegetariana") do |post|
  post.description = <<-EOF
  Comparto conocimientos sobre alimentación vegetariana equilibrada: planificación 
  de menús semanales, alternativas proteicas, combinación de alimentos y recetas
  saludables. Te ayudo a incorporar más vegetales a tu dieta de forma sabrosa y nutritiva.
  EOF
  post.category_id = 2 # Salud
  post.user_id = guille_id
  post.tags = ["Nutrición", "Vegetariano", "Alimentación"]
  post.organization_id = org4.id
end

Offer.find_or_create_by(title: "Reparación de bicicletas") do |post|
  post.description = <<-EOF
  Realizo mantenimiento y pequeñas reparaciones de bicicletas: ajuste de frenos,
  cambios, pinchazo de ruedas, lubricación de cadena, etc. También puedo
  asesorarte si estás pensando en comprar una bicicleta según tus necesidades.
  EOF
  post.category_id = 9 # Otros
  post.user_id = guille_id
  post.tags = ["Bicicletas", "Reparación", "Mantenimiento"]
  post.organization_id = org4.id
end

# Ofertas para admin5 (Banco 5)
Offer.find_or_create_by(title: "Yoga terapéutico") do |post|
  post.description = <<-EOF
  Sesiones de yoga adaptado para personas con movilidad reducida, 
  dolores crónicos o recuperándose de lesiones. Ejercicios suaves 
  con atención personalizada para mejorar tu bienestar físico y mental.
  EOF
  post.category_id = 2 # Salud
  post.user_id = admin5_id
  post.tags = ["Yoga", "Terapia", "Bienestar"]
  post.organization_id = org5.id
end

Offer.find_or_create_by(title: "Asesoramiento en consumo responsable") do |post|
  post.description = <<-EOF
  Te oriento sobre cómo reducir tu huella ecológica, consumir de forma más 
  responsable y ahorrar dinero. Desde consejos para compras más sostenibles
  hasta ideas para reducir residuos en el hogar y aprovechar recursos.
  EOF
  post.category_id = 8 # Asesoramiento
  post.user_id = admin5_id
  post.tags = ["Ecología", "Sostenibilidad", "Consumo"]
  post.organization_id = org5.id
end

Offer.find_or_create_by(title: "Costura y arreglos de ropa") do |post|
  post.description = <<-EOF
  Realizo arreglos básicos de ropa: dobladillos, zurcidos, botones, cremalleras, etc.
  También puedo hacer pequeñas modificaciones para adaptar prendas a tu talla.
  Dales una segunda vida a tus prendas favoritas.
  EOF
  post.category_id = 3 # Tareas domésticas
  post.user_id = admin5_id
  post.tags = ["Costura", "Arreglos", "Ropa"]
  post.organization_id = org5.id
end

# Ofertas para user5 (Banco 5)
Offer.find_or_create_by(title: "Diseño y mantenimiento de huertos urbanos") do |post|
  post.description = <<-EOF
  Ayudo a diseñar, crear y mantener pequeños huertos urbanos en terrazas, 
  balcones o pequeños espacios. Asesoramiento sobre cultivos de temporada, 
  técnicas ecológicas y soluciones para espacios reducidos.
  EOF
  post.category_id = 9 # Otros
  post.user_id = user5_id
  post.tags = ["Huerto", "Cultivo", "Ecológico"]
  post.organization_id = org5.id
end

Offer.find_or_create_by(title: "Préstamo de libros y lecturas comentadas") do |post|
  post.description = <<-EOF
  Dispongo de una amplia biblioteca personal que puedo prestar. Además, 
  organizo sesiones de lectura comentada donde compartimos impresiones 
  sobre un mismo libro. Ideal para amantes de la literatura o personas 
  que quieran fomentar su hábito de lectura.
  EOF
  post.category_id = 10 # Préstamo
  post.user_id = user5_id
  post.tags = ["Libros", "Lectura", "Literatura"]
  post.organization_id = org5.id
end

Offer.find_or_create_by(title: "Gestión de redes sociales para iniciativas locales") do |post|
  post.description = <<-EOF
  Ayudo a pequeñas iniciativas comunitarias o proyectos locales a gestionar 
  sus redes sociales: creación de contenido, programación, estrategias básicas 
  para aumentar visibilidad. Especial atención a proyectos sociales o sostenibles.
  EOF
  post.category_id = 4 # Tareas administrativas
  post.user_id = user5_id
  post.tags = ["Redes sociales", "Marketing", "Comunicación"]
  post.organization_id = org5.id
end

# Inquiries
Inquiry.find_or_create_by(title: "Ayuda a organizarme con los tupper") do |post|
  post.description = <<-EOF
  Me cuesta **organizarme con los tupper** me gustaría poder preparar los tupper de toda la semana el domingo, pero para eso necesito consejos y organización ;)
  EOF
  post.category_id = 7
  post.user_id = 1
  post.tags = ["Cocinar", "Cocina", "Tupper"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Quiero aprender a programar") do |post|
  post.description = <<-EOF
  Si, pues eso que me gustaría aprender a programar en Ruby on Rails, de momento solo se hacer copy & paste, me gustaría que alguien se sentara a mi lado para explicarme mejor algunas cosas
  EOF
  post.category_id = 5
  post.user_id = 1
  post.tags = ["Rails", "Ruby", "programación"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Cocina Tailandesa") do |post|
  post.category_id = 7
  post.user_id = 1
  post.tags = ["Tailandesa", "Cocina"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Cocinar Sushi") do |post|
  post.description = <<-EOF
  Quiero aprender a cocinar sushi del bueno. ![Sushi del bueno](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVixUvEhTshPcin46IJAIDPb8fAjvGH7jcPwbye3ypyVuqqgVD)
  EOF
  post.category_id = 7
  post.user_id = 3
  post.tags = ["Cocinar", "Cocina", "Tupper"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Aprender cocina Libanesa") do |post|
  post.description = <<-EOF
  Humus, falafel, labne, mohamara, kebap y todas estas cosas...
  EOF
  post.category_id = 7
  post.user_id = 3
  post.tags = ["Cocinar", "Cocina", "Tupper"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Conversación en Inglés") do |post|
  post.description = <<-EOF
  Necesito aprendrender ingles urgentemente ya que en dos meses me voy a vivir a Chicago y voy a necesitar inglés fluido
  EOF
  post.category_id = 5
  post.user_id = 1
  post.tags = ["Inglés", "gramática", "Conversación"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Clases de Italiano") do |post|
  post.description = <<-EOF
  Mi farò prestare un soldino di sole
  perchè regalare lo voglio a te?
  Lo potrai posare sui biondi capelli:
  quella nube d'oro accarezzerò...

  Questa piccolissima serenata
  con un fìl di voce si può cantar?
  Ogni innamorato all'innamorata
  la sussurrerà, la sussurrerà?
  EOF
  post.category_id = 5
  post.user_id = 1
  post.tags = ["Italiano", "clases", "Conversación"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Alguien que me explique Markdown") do |post|
  post.description = <<-EOF
  No lo entiendo, todo el mundo publica anuncios con imagenes, negritas, cursivas y yo no se hacerlo... alguien me lo explica??
  EOF
  post.category_id = 5
  post.user_id = 1
  post.tags = ["Markdown"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Quiero hacer Yoga") do |post|
  post.description = <<-EOF
  Me gustaría abrir mis chakras y conectarme con el universo para ser uno con él. Un ser completo y superior. Vamos que quiero ser más flexible.
  EOF
  post.category_id = 5
  post.user_id = 2
  post.tags = ["Yoga", "Estiramientos", "Respiración", "flexibilidad"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Practicar Meditación transcendental") do |post|
  post.description = <<-EOF
  Busco un maestro o un gurú. Paz interior y calma como un lago lleno de peces tranquilos.
  EOF
  post.category_id = 5
  post.user_id = 2
  post.tags = ["Meditación", "Estiramientos", "Respiración", "flexibilidad"]
  post.organization_id = 1
end

Inquiry.find_or_create_by(title: "Clases de Alemán") do |post|
  post.description = <<-EOF
  Necesito practicar un Alemán básico, ya que me voy a Berlin a trabajar, por fin, he conseguido trabajo como ingeniero, me ayudas???
  EOF
  post.category_id = 5
  post.user_id = 1
  post.tags = ["Aleman", "Deutsche", "Conversación"]
  post.organization_id = 1
end

Document.find_or_create_by(label: "t&c") do |doc|
  doc.title = "Terminos de Servicio TimeOverflow"
  doc.content = <<-EOF
  TimeOverflow es un software libre desarrollado por voluntarios que tiene como finalidad facilitar, mediante tecnologías de la información, los procesos funcionales de un Banco de Tiempo. TimeOverflow permite la gestión de un Banco de Tiempo por parte de usuarios administradores y facilita el contacto entre todos los usuarios de un Banco de Tiempo.

  La Asociación para el Desarrollo de los Bancos de Tiempo, en adelante ADBdT, es una asociación sin ánimo de lucro que trabaja para desarrollar los Bancos de Tiempo. La ADBdT ofrece una instalación on-line de TimeOverflow y lo hace de manera gratuita para cualquier Banco de Tiempo que se lo solicite. El uso de esta aplicación on-line implica la aceptación previa, por parte de los administradores que gestionarán el Banco de Tiempo y de todos sus usuarios, de estos términos de servicio así como de sus futuras modificaciones.

  Ofrecemos esta aplicación on-line esperando que sea de gran utilidad para los Bancos de Tiempo, sin embargo no podemos ofrecer NINGUNA GARANTÍA sobre su correcto funcionamiento. La ADBdT mantiene esta instalación on-line gracias a las aportaciones de sus socios y seguirá ofreciendo este servicio siempre que le sea posible, en este sentido, se exime a la ADBdT de cualquier tipo de responsabilidad en cuanto al funcionamiento, así como sobre el acceso o disponibilidad de descarga de dicho programa.

  La ADBdT realiza copias de seguridad de la base de datos de TimeOverflow de manera regular con la finalidad de evitar posibles perdidas accidentales de datos y se compromete a atender cualquier incidencia, es por ello que con el uso de esta aplicación e inherente aceptación de estos términos de servicio, los Bancos del Tiempo reconocen haber obtenido el consentimiento expreso de cualquiera de sus socios y/o usuarios a los efectos de cesión y/o acceso de sus datos a terceros para poder atender a los servicios derivados del uso de TimeOverflow. Sin perjuicio de lo anterior, la ADBdT sólo accederá de manera puntual a los datos con finalidades estadísticas o técnicas manteniendo siempre el anonimato de los usuarios.

  La ADBdT no es responsable de la privacidad y protección de los datos de los usuarios de un Banco de Tiempo. Los responsables de los datos personales en un Banco de Tiempo son sus administradores, los cuales deben tener consentimiento expreso de sus usuarios y cumplir con la Ley Orgánica 15/1999, de 13 de diciembre de protección de datos. Cualquier divergencia que pudiera surgir con la ADBdT se someterá a la normativa española, así como se tratará ante los Juzgados y Tribunales de Barcelona, con renuncia expresa a cualquier otro fuero o norma que resultara de aplicación.

  Este servicio es ofrecido por la ADBdT con NIF:G65875031 que puede ser contactada en su dirección postal Carrer de la Providència, 42 (Hotel Entitats) 08024 Barcelona o bien mediante correo electrónico en adbdt.info@gmail.com
  EOF
end
