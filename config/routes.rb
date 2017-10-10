Rails.application.routes.draw do
	match '/sums' => 'documents#sums', via: :post

	match '/filters' => 'documents#filters', via: :post

	match '/intervals' => 'documents#intervals', via: :post

	match '/lin_regressions' => 'documents#lin_regressions', via: :post
end
