namespace :fix_embed_youtube_identifier do
    desc 'IDを入力していたidentiferカラムの過去データを一括で修正'
    task update_old_identifier_for_youtube_embed: :environment do
      Embed.youtube.each do |embed|
        embed.update(identifier: "https://youtu.be/#{embed.identifier}")
      end
    end
  end