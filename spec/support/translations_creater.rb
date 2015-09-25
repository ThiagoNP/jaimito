class TranslationsCreater
  def self.create_classes_name(key, value)
    I18n.backend.store_translations(:en, {
      jaimito: {translated_classes_names: {key => value}}
    })

    I18n.backend.store_translations(:pt, {
      jaimito: {translated_classes_names: {key => value}}
    })
  end

  def self.create_attributes_name(class_name, key, value)
    I18n.backend.store_translations(:en, {jaimito: {translated_attributes_names: { class_name => {key => value}}
    }})

    I18n.backend.store_translations(:pt, {
      jaimito: {translated_attributes_names: { class_name => {key => value}}
    }})
  end
end
