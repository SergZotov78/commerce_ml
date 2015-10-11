class CommercemlSave

  private

  def self.save(request, file_name)
    tmp_file = "#{Rails.root}/public/uploads/full/#{file_name}"
    File.open(tmp_file, 'wb') do |f|
      f.write  request.body.read
    end
    File.size(tmp_file) == request.body.size ? 'success' : 'failure'
  end

  def self.check(tmp_file)
    tmp_file = "#{Rails.root}/public/uploads/full/#{tmp_file}"
    File.exist?(tmp_file) ? 'success' : 'failure'
  end
end