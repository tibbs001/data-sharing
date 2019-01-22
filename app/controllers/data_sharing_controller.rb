class DataSharingController < ApplicationController

  def index
    @dataset_count = SharableDataset.all.size
    @datasets = SharableDataset.order(:dataset)
    respond_to do |format|
      format.html
      format.csv { render text: @datasets.to_csv }
      format.xls { render text: @datasets.to_csv(col_sep: "\t") }
    end
  end

  def edit
  end

  def show
    @dataset_count = SharableDataset.all.size
    @datasets = SharableDataset.order(:dataset)
    respond_to do |format|
      format.html
      format.csv { render text: @datasets.to_csv }
      format.xls { render text: @datasets.to_csv(col_sep: "\t") }
    end
  end

end

