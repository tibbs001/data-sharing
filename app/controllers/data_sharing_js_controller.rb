class DataSharingController < ApplicationController

  def show
    dataOut = []
    data=get_datasets
    header = data.first
    (2..data.last_row).each do |i|
      row = Hash[[header, data.row(i)].transpose]
      if !row['dataset'].nil?
        dataOut << row
      end
    end
    dataOut.each{|x| puts x['dataset']}
    dataOut
    #render json: dataOut, root: false
  end

  def index
    dataOut = []
    data=get_datasets
    header = data.first
    (2..data.last_row).each do |i|
      row = Hash[[header, data.row(i)].transpose]
      if !row['dataset'].nil?
        dataOut << row
      end
    end
    render json: dataOut, root: false
  end

  def get_datasets
    Roo::Spreadsheet.open("/aact-files/documentation/sharable_datasets.xlsx")
  end

  def searchable_attribs
    ['dataset', 'study_type', 'therapeutic_area', 'enrollment', 'population', 'phase', 'faculty_name', 'affiliation']
  end

end
