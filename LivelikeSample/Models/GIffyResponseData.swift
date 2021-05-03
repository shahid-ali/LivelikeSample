//
//  GIffyResponseData.swift
//  LivelikeSample
//
//  Created by Shahid Ali on 4/12/21.
//



struct GIffyResponseData: Codable {
	var data:[GiffyItem]?
	var pagination:Pagination
	var meta:Meta
}

struct Pagination:Codable
{
	var total_count:Int?
	var count:Int?
	var offset:Int?
}

struct Meta:Codable
{
	var status:Int
	var msg:String
	var response_id:String
}

	  
   
