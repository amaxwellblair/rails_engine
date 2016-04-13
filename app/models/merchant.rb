class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def self.most_revenue(num)
    joins(invoices: [:transactions, :invoice_items]).where("transactions.result = 'success'").select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS tot").group("merchants.id").order("tot desc").first(num)
  end

  def revenue(date = nil)
    if date.nil?
      revenue = invoices.joins(:transactions).where("transactions.result = 'success'").uniq.includes(:invoice_items).sum("quantity * unit_price")
      return { "revenue" => revenue }
    else
      revenue = invoices.joins(:transactions).where("transactions.result = 'success'").where("invoices.created_at = ?", date).uniq.includes(:invoice_items).sum("quantity * unit_price")
      return { "revenue" => revenue }
    end
  end

  def self.most_items(num)
    joins(invoices: [:transactions, :invoice_items]).where("transactions.result = 'success'").select("merchants.*, SUM(invoice_items.quantity) AS tot").group("merchants.id").order("tot desc").first(num)
  end

  def self.revenue_by_date(date)
    revenue = joins(invoices: [:transactions, :invoice_items]).where("transactions.result = 'success'").where("invoices.created_at = ?", date).uniq.sum("invoice_items.quantity * invoice_items.unit_price")
    return { "total_revenue" => revenue }
  end
end
