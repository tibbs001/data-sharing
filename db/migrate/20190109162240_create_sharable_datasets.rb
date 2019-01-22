class CreateSharableDatasets < ActiveRecord::Migration

  def change
    create_table "ctgov.sharable_datasets" do |t|
      t.string    :dataset
      t.string    :title
      t.string    :study_type
      t.string    :start_date
      t.string    :end_date
      t.string    :therapeutic_area
      t.string    :enrollment
      t.string    :population
      t.string    :phase
      t.string    :study_description
      t.string    :data_availability
      t.string    :faculty_name
      t.string    :affiliation
      t.string    :governance
      t.string    :data_source
      t.string    :primary_dcri_contact
      t.string    :secondary_dcri_contact
      t.string    :operational_dcri_contact
      t.string    :observation_type
      t.string    :intervention_type
      t.string    :drug
      t.string    :sponsor_name
      t.string    :sponsor_type
      t.string    :randomized
      t.string    :biospecimen
      t.string    :data_location
      t.string    :control
      t.string    :blinding
      t.string    :international
      t.string    :study_population
      t.timestamps null: false
    end
  end

end
