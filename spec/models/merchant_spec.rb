require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items)}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
  end

  describe 'instance methods' do
    describe '.most_popular_items' do
      it 'should return the 5 most popular items for some merchant in terms of
          total revenue generated' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 2500)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 1000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 40)
        item_4 = merchant_1.items.create!(name: "1984 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 60)
        item_5 = merchant_1.items.create!(name: "1991 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 90)
        item_6 = merchant_1.items.create!(name: "1993 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 70)
        item_7 = merchant_1.items.create!(name: "2004 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 20)
        item_8 = merchant_1.items.create!(name: "1997 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 10)
        item_9 = merchant_1.items.create!(name: "1996 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 10)
        item_10 = merchant_1.items.create!(name: "1975 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 40)
        customer_1 = Customer.create!(first_name: "Guthrie", last_name: "Govan")
        invoice_1 = customer_1.invoices.create!(status: 1)
        invoice_2 = customer_1.invoices.create!(status: 0)
        invoice_3 = customer_1.invoices.create!(status: 1)
        invoice_item_1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 1, unit_price: item_1.unit_price, status: 0)
        invoice_item_2 = InvoiceItem.create!(item: item_9, invoice: invoice_1, quantity: 25, unit_price: item_9.unit_price, status: 0)
        invoice_item_3 = InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 1, unit_price: item_2.unit_price, status: 0)
        invoice_item_4 = InvoiceItem.create!(item: item_4, invoice: invoice_1, quantity: 31, unit_price: item_4.unit_price, status: 0)
        invoice_item_5 = InvoiceItem.create!(item: item_3, invoice: invoice_1, quantity: 35, unit_price: item_3.unit_price, status: 0)
        invoice_item_6 = InvoiceItem.create!(item: item_5, invoice: invoice_1, quantity: 10, unit_price: item_5.unit_price, status: 0)
        invoice_item_7 = InvoiceItem.create!(item: item_6, invoice: invoice_1, quantity: 17, unit_price: item_6.unit_price, status: 0)
        invoice_item_8 = InvoiceItem.create!(item: item_8, invoice: invoice_1, quantity: 22, unit_price: item_8.unit_price, status: 0)
        invoice_item_9 = InvoiceItem.create!(item: item_7, invoice: invoice_1, quantity: 1, unit_price: item_7.unit_price, status: 0)
        invoice_item_10 = InvoiceItem.create!(item: item_10, invoice: invoice_1, quantity: 4, unit_price: item_10.unit_price, status: 0)
        invoice_item_11 = InvoiceItem.create!(item: item_5, invoice: invoice_2, quantity: 10000, unit_price: item_5.unit_price, status: 0)
        invoice_item_12 = InvoiceItem.create!(item: item_7, invoice: invoice_2, quantity: 10000, unit_price: item_7.unit_price, status: 0)
        invoice_item_13 = InvoiceItem.create!(item: item_8, invoice: invoice_3, quantity: 10000, unit_price: item_8.unit_price, status: 0)
        transaction_1 = invoice_1.transactions.create!(credit_card_number: 0000111122223333, result: "success")
        transaction_2 = invoice_2.transactions.create!(credit_card_number: 0000111122223333, result: "failed")
        transaction_3 = invoice_3.transactions.create!(credit_card_number: 0000111122223333, result: "success")

        expect(merchant_1.most_popular_items).to eq([item_8, item_1, item_4, item_3, item_6])
      end

      describe '.distinct_invoices' do
        it 'returns all invoices that have any of the merchants items without duplicates' do
          merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
          item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                          description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                          unit_price: 25000000)
          item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                          description: "Seafoam Green Finish, Maple Fingerboard",
                                          unit_price: 10000000)
          item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                          description: "Cherry Red Finish, Rosewood Fingerboard",
                                          unit_price: 400000)
          merchant_2 = Merchant.create!(name: "Bob's Less Rare Guitars")
          item_4 = merchant_2.items.create!(name: "2006 Ibanez GX500",
                                            description: "Green Burst Finish, Rosewood Fingerboard",
                                            unit_price: 50000)
          item_5 = merchant_2.items.create!(name: "2013 ESP GH100",
                                            description: "Black Finish, Ebony Fingerboard",
                                            unit_price: 40000)
          customer_1 = Customer.create!(first_name: "Guthrie", last_name: "Govan")
          invoice_1 = customer_1.invoices.create!(status: 1)
          invoice_2 = customer_1.invoices.create!(status: 0)
          invoice_3 = customer_1.invoices.create!(status: 1)
          invoice_item_1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 1, unit_price: item_1.unit_price, status: 0)
          invoice_item_2 = InvoiceItem.create!(item: item_2, invoice: invoice_2, quantity: 25, unit_price: item_2.unit_price, status: 0)
          invoice_item_3 = InvoiceItem.create!(item: item_3, invoice: invoice_2, quantity: 1, unit_price: item_3.unit_price, status: 0)
          invoice_item_4 = InvoiceItem.create!(item: item_4, invoice: invoice_1, quantity: 31, unit_price: item_4.unit_price, status: 0)
          invoice_item_5 = InvoiceItem.create!(item: item_5, invoice: invoice_1, quantity: 35, unit_price: item_5.unit_price, status: 0)
          invoice_item_5 = InvoiceItem.create!(item: item_4, invoice: invoice_3, quantity: 35, unit_price: item_5.unit_price, status: 0)

          expect(merchant_1.distinct_invoices).to eq([invoice_1, invoice_2])
          expect(merchant_1.distinct_invoices.length).to eq(2)
        end
      end
    end
  end
  
  describe 'calculate revenue methods' do
    before :each do
      @customer = Customer.create!(first_name: 'Jim', last_name: 'Jones')

      @merchant_1 = Merchant.create!(name: 'Jones Meats')
      @item_1 = @merchant_1.items.create!(name: 'Ribeye', unit_price: 75, description: 'Boneless Cut')
      @invoice_1 = @customer.invoices.create!(status: 'completed')
      @invoice_1.transactions.create!(credit_card_number: '123456789', result: 'success')
      @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 2, unit_price: 75, status: 'packaged')

      @merchant_2 = Merchant.create!(name: 'Sals Spice Rubs')
      @item_2 = @merchant_2.items.create!(name: 'Ribeye', unit_price: 75, description: 'Boneless Cut')
      @invoice_2 = @customer.invoices.create!(status: 'completed')
      @invoice_2.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_3 = @customer.invoices.create!(status: 'completed')
      @invoice_3.transactions.create!(credit_card_number: '123456789', result: 'success')
      @item_2.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_2.invoice_items.create!(invoice_id: @invoice_3.id, quantity: 2, unit_price: 75, status: 'packaged')

      @merchant_3 = Merchant.create!(name: 'City Fresh Meats')
      @item_3 = @merchant_3.items.create!(name: 'Ribeye', unit_price: 75, description: 'Boneless Cut')
      @invoice_4 = @customer.invoices.create!(status: 'completed')
      @invoice_4.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_5 = @customer.invoices.create!(status: 'completed')
      @invoice_5.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_6 = @customer.invoices.create!(status: 'completed')
      @invoice_6.transactions.create!(credit_card_number: '123456789', result: 'success')
      @item_3.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_3.invoice_items.create!(invoice_id: @invoice_5.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_3.invoice_items.create!(invoice_id: @invoice_6.id, quantity: 2, unit_price: 75, status: 'packaged')

      @merchant_4 = Merchant.create!(name: 'For Real Meat')
      @item_4 = @merchant_4.items.create!(name: 'Ribeye', unit_price: 75, description: 'Boneless Cut')
      @invoice_7 = @customer.invoices.create!(status: 'completed')
      @invoice_7.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_8 = @customer.invoices.create!(status: 'completed')
      @invoice_8.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_9 = @customer.invoices.create!(status: 'completed')
      @invoice_9.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_10 = @customer.invoices.create!(status: 'completed')
      @invoice_10.transactions.create!(credit_card_number: '123456789', result: 'success')
      @item_4.invoice_items.create!(invoice_id: @invoice_7.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_4.invoice_items.create!(invoice_id: @invoice_8.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_4.invoice_items.create!(invoice_id: @invoice_9.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_4.invoice_items.create!(invoice_id: @invoice_10.id, quantity: 2, unit_price: 75, status: 'packaged')

      @merchant_5 = Merchant.create!(name: 'Drews Steak Serenium')
      @item_5 = @merchant_5.items.create!(name: 'Ribeye', unit_price: 75, description: 'Boneless Cut')
      @invoice_11 = @customer.invoices.create!(status: 'completed')
      @invoice_11.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_12 = @customer.invoices.create!(status: 'completed')
      @invoice_12.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_13 = @customer.invoices.create!(status: 'completed')
      @invoice_13.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_14 = @customer.invoices.create!(status: 'completed')
      @invoice_14.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_15 = @customer.invoices.create!(status: 'completed')
      @invoice_15.transactions.create!(credit_card_number: '123456789', result: 'success')
      @item_5.invoice_items.create!(invoice_id: @invoice_11.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_5.invoice_items.create!(invoice_id: @invoice_12.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_5.invoice_items.create!(invoice_id: @invoice_13.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_5.invoice_items.create!(invoice_id: @invoice_14.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_5.invoice_items.create!(invoice_id: @invoice_15.id, quantity: 2, unit_price: 75, status: 'packaged')

      @merchant_6 = Merchant.create!(name: 'Cattlemans Steakhouse')
      @item_6 = @merchant_6.items.create!(name: 'Ribeye', unit_price: 75, description: 'Boneless Cut')
      @invoice_16 = @customer.invoices.create!(status: 'completed')
      @invoice_16.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_17 = @customer.invoices.create!(status: 'completed')
      @invoice_17.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_18 = @customer.invoices.create!(status: 'completed')
      @invoice_18.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_19 = @customer.invoices.create!(status: 'completed')
      @invoice_19.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_20 = @customer.invoices.create!(status: 'completed')
      @invoice_20.transactions.create!(credit_card_number: '123456789', result: 'success')
      @invoice_21 = @customer.invoices.create!(status: 'completed')
      @invoice_21.transactions.create!(credit_card_number: '123456789', result: 'success')
      @item_6.invoice_items.create!(invoice_id: @invoice_16.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_6.invoice_items.create!(invoice_id: @invoice_17.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_6.invoice_items.create!(invoice_id: @invoice_18.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_6.invoice_items.create!(invoice_id: @invoice_19.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_6.invoice_items.create!(invoice_id: @invoice_20.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_6.invoice_items.create!(invoice_id: @invoice_21.id, quantity: 2, unit_price: 75, status: 'packaged')

      @merchant_7 = Merchant.create!(name: 'Wills Sad Meats')
      @item_7 = @merchant_7.items.create!(name: 'Ribeye', unit_price: 75, description: 'Boneless Cut')
      @invoice_22 = @customer.invoices.create!(status: 'completed')
      @invoice_22.transactions.create!(credit_card_number: '123456789', result: 'failed')
      @item_7.invoice_items.create!(invoice_id: @invoice_22.id, quantity: 2, unit_price: 75, status: 'packaged')

      @merchant_8 = Merchant.create!(name: 'Overcharge Inc')
      @item_8 = @merchant_8.items.create!(name: 'Ribeye', unit_price: 75, description: 'Boneless Cut')
      @invoice_23 = @customer.invoices.create!(status: 'completed')
      @invoice_23.transactions.create!(credit_card_number: '123456789', result: 'failed')
      @invoice_24 = @customer.invoices.create!(status: 'completed')
      @invoice_24.transactions.create!(credit_card_number: '123456789', result: 'success')
      @item_8.invoice_items.create!(invoice_id: @invoice_23.id, quantity: 2, unit_price: 75, status: 'packaged')
      @item_8.invoice_items.create!(invoice_id: @invoice_24.id, quantity: 2, unit_price: 75, status: 'packaged')
    end

    it '.total_revenue returns the total revenue for merchants with 1 or more successful transaction' do
      expect(@merchant_1.total_revenue).to eq(150)
      expect(@merchant_2.total_revenue).to eq(300)
      expect(@merchant_3.total_revenue).to eq(450)
      expect(@merchant_4.total_revenue).to eq(600)
      expect(@merchant_5.total_revenue).to eq(750)
      expect(@merchant_6.total_revenue).to eq(900)
    end

    it '.top_five returns the top 5 merchants by revenue'

  end
end
