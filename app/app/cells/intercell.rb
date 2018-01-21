require "cell/translation"

# Intercell позволяет
# - Пользоваться хелпером t для переводов
# Например, для cell Directions::Links
# t(.key) ищет ключ 'locale.directions.links.key'
class Intercell < Cell::ViewModel
  include ActionView::Helpers::TranslationHelper
  include Cell::Translation
end
