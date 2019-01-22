class SharableDataset < ActiveRecord::Base

  def self.populate
    data=Roo::Spreadsheet.open("#{Rails.public_path}/documentation/sharable_datasets.xlsx")
    self.destroy_all
    self.populate_from_file(data)
  end

  def self.populate_from_file(data)
    header = data.first
    dataOut = []
    (2..data.last_row).each do |i|
      row = Hash[[header, data.row(i)].transpose]
      if !row['dataset'].nil?
        new(:dataset           => row['dataset'],
            :title             => row['title'],
            :study_type        => row['study_type'],
            :start_date        => row['start_date'],
            :end_date          => row['end_date'],
            :therapeutic_area  => row['therapeutic_area'],
            :enrollment        => row['enrollment'],
            :population        => row['population'],
            :phase             => row['phase'],
            :study_description => row['study_description'],
            :data_availability => row['data_availability'],
            :faculty_name      => row['faculty_name'],
            :affiliation       => row['affiliation'],
            :governance        => row['governance'],
            :data_source       => row['data_source'],
            :primary_dcri_contact     => row['primary_dcri_contact'],
            :secondary_dcri_contact   => row['secondary_dcri_contact'],
            :operational_dcri_contact => row['operational_dcri_contact'],
            :observation_type         => row['observation_type'],
            :intervention_type        => row['intervention_type'],
            :drug                     => row['drug'],
            :sponsor_name      => row['sponsor_name'],
            :sponsor_type      => row['sponsor_type'],
            :randomized        => row['randomized'],
            :biospecimen       => row['biospecimen'],
            :data_location     => row['data_location'],
            :control           => row['control'],
            :blinding          => row['blinding'],
            :international     => row['international'],
            :study_population  => row['study_population'],
           ).save!
      end
    end
  end

end
