class DailyImportDatabaseWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(2) }

  def perform
    ProductImporter.new.import
    CostImporter.new.import
  end
end