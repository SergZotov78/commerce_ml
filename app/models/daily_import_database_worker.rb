class DailyImportDatabaseWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(12) }

  def perform
    ProductImporter.new.import
    CostImporter.new.import
  end
end