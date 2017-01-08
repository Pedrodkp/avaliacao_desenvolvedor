class Sale < ActiveRecord::Base
  def self.import(file)
    if file != nil
      Sale.where(source_file: file.original_filename).destroy_all

      CSV.foreach(file.path, headers: true, :col_sep => "\t") do |row|      
        Sale.create!(customer: row[0],
                     description: row[1],
                     price: row[2],
                     amount: row[3],
                     address: row[4],
                     furnisher: row[5],
                     source_file: file.original_filename)
      end
    end
  end
end
