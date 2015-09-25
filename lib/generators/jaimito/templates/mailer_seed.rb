ActiveRecord::Base.transaction do
  MailTemplate.create!(
    subject: 'Welcome [[User - Name]]!',
    body: %Q(
      <b>Welcome [[User - Name]]</b> to our platform!
      <br>
      <a href='example'>Click here</a> if you don't wish to receive emails.
    ),
    mailer_name: 'sample_mailer',
    method_name: 'welcome_mail',
    locale: :en
  )

  MailTemplate.create!(
    subject: 'Bem vindo [[Usuário - Nome]]!',
    body: %Q(
      <b>Bem vindo [[Usuário - Nome]]</b>!
      <br>
      <a href='example'>Clique aqui</a> para cancelar o recebimento de emails.
    ),
    mailer_name: 'sample_mailer',
    method_name: 'welcome_mail',
    locale: :'pt-br'
  )
end
