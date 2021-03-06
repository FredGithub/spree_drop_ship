require 'spec_helper'

describe Spree::Shipment do

  it '#drop_ship_order' do
    order = create(:order_ready_for_drop_ship).drop_ship_orders.first
    order.shipments.first.drop_ship_order.should eql(order)
  end

  describe '#after_ship' do

    it 'should set drop ship order to complete if all shipments have shipped' do
      order = create(:order_ready_for_drop_ship).drop_ship_orders.first
      order.state.should_not eql('completed')
      order.shipments.each do |shipment|
        shipment.ship!
      end
      order.reload.state.should eql('completed')
    end

    it 'should capture payment if balance due' do
      pending
    end

  end

end
