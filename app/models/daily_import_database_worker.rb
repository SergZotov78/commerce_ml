class DailyImportDatabaseWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily(1) }

  def perform
    ProductImporter.new.import
    CostImporter.new.import
  end
end