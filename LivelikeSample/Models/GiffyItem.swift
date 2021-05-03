//
//  GiffyItem.swift
//  LivelikeSample
//
//  Created by Shahid Ali on 4/12/21.
//

struct GiffyItem: Codable {
	var type:String?
	var id:String?
	var url:String?
	var slug:String?
	var bitly_gif_url:String?
	var bitly_url:String?
	var embed_url:String?
	var username:String?
	var source:String?
	var title:String?
	var rating:String?
	var content_url:String?
	var source_tld:String?
	var source_post_url:String?
	var is_sticker:Int?
	var import_datetime:String?
	var trending_datetime:String?
	var images:GiffyImageItem?
	var user:GiffyUserItem?
	var analytics_response_payload:String?
	
}
