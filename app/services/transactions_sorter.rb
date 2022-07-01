class TransactionsSorter < BaseService
  attr_accessor :transactions, :params

  def initialize(transactions:, params: {})
    @transactions = transactions.includes(:category).order(created_at: :desc)
    @params = params
  end

  def call
    return transactions if params.empty?

    filter_by_wallet_and_category
    filter_by_type
    filter_by_time
    filter_by_words

    @transactions
  end

  private

  def filter_by_wallet_and_category
    %i[wallet_id category_id].each do |filter|
      return unless params[filter].present?

      @transactions = @transactions.where("#{filter}": params[filter])
    end
  end

  def filter_by_type
    if params[:type].present?
      return unless Transaction::TYPES.include?(params[:type].to_sym)

      @transactions = @transactions.send(params[:type])
    end
  end

  def filter_by_time
    if params[:start_date].present?
      @transactions = @transactions.where(
        created_at: params[:start_date].to_date.beginning_of_day..params[:end_date].to_date.end_of_day
      )
    end
  end

  def filter_by_words
    if params[:query].present?
      @transactions = @transactions.where('note ILIKE ?', "%#{params[:query]}%")
    end
  end
end
